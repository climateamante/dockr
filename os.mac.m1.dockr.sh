#!/usr/bin/env bash
# version: 0.1.4.01
# previous: 06.11.2018
# current: 10.05.2018
# about: Dockr is a set of scripts and helper tools to avoid remembering complex docker commands


# TODO: converstion process into a propper CLI tool with testing
# TODO: create documentation and --help --version commands
# TODO: CLEAR ALL CONTAINER CACHE
# USE WITH CAUTION! -> docker ps -q | xargs docker stop ; docker system prune -a
# https://gist.github.com/evanscottgray/8571828

# _dockr_error_message(){
# 	local error_message=$(cat <<-EOF
# 	error: missing sub command paramater
# 	example: dockr image --sort
# 	EOF)
# }

_dockr_error_message="error: missing sub command paramater"

dockr(){
	local version_number='0.1.4.01'
	local docker_command=$1;
	local docker_sub_command=$2;
	local dockr_paramaters="${@}";
	local docker_subcommands=($(echo "${dockr_paramaters[@]}" | tr ' ' '\n'))	
	local error_message=$_dockr_error_message

		case "${docker_command}" in
		"clean" | "-clean")
			docker_clean "${docker_sub_command}";
			;;
		"close" | "--close")
			docker_close_containers "${docker_sub_command}";
			;;
		"compose" | "-comp" | "-compose")
			docker_compose_build
			;;
		"container" | "containers" | "-c" | "-container" | "--containers")
			docker_list_all_containers
			;;
		"down" | "-d" | "-down")
			docker_down
			;;
		"image" | "images" | "-i" | "--image" | "--images")
			docker_list_all_images
			;;
		"ip" | "-ip")
			docker_ip
			;;
		"push" | "-p" | "--push")
			docker_push
			;;			
		"remove" | "-remove" | "--remove")
			docker_remove_container "${docker_sub_command}";
			;;
		"removeall" | "-removeall" | "--removeall")
			docker_remove_all_images_and_containers
			;;
		"run" | "-r" | "--run")
			# @ symbol used to pass all arguments #
			docker_run "${2}" "${3}"
			;;
		"ssh" | "-ssh")
			# docker_ssh "${docker_sub_command}";
			docker_ssh "${@}";
			;;
		"stop" | "--stop")
			docker_close_containers "${docker_sub_command}";
			;;
		"up" | "-u" | "-up")
			docker_up;
			;;
		"version" | "--version" | "-v" )
			echo "dockr:  ${version_number}";
			;;
	* ) echo " * error - no input command "
		echo "$(docker --version)"
		# echo "$(docker-machine env)"
		;;
	esac
}



# -- Helper Functions -- #

function docker_push () {
	local docker_image="${docker_sub_command}"
		
	if [ -z "${docker_image}" ];
 	then
		echo 'error: no image passed to upload'
		echo 'example: dockr --push nginx/alpine:latest'
	else
		docker push "${docker_image}"
	fi	
	
}




function docker_close_containers () {
	
	local docker_close_subcommand="${1}"

	if [ "${docker_close_subcommand}" == "--all" ];
 	then
		docker stop $(docker ps -a -q);
		
	elif [ ! -z "${docker_close_subcommand}" ];
	then	
		local docker_container_id="${docker_close_subcommand}"
		docker stop "${docker_container_id}";
		
	elif [ -z "${docker_close_subcommand}" ];
	then
		echo 'error: no container id passed'
		echo 'exmaple: dockr close f570b81b2a4e'
		echo 'tip: to close all running containers'
		echo 'example: dockr close --all'
	fi
}


function docker_run (){
	local docker_image_id="${1}"
	local docker_container_command="${2}"
	
	# -- check if image id is null --#
	if [ -z "${docker_image_id}" ] || [ -z "${docker_container_command}" ];
 	then
		echo 'error: no image:version id passed'
		echo 'error: no shell command not passed'
		echo 'example: dockr run image:version /bin/sh'
	else
		docker run -itd --rm "${docker_image_id}" "${docker_container_command}"
		
			# -i
			# interactive process (shell/bash/etc)
			# Keep STDIN open even if not attached

			# -t
			# Allocate a pseudo-tty
			
			# -d
			# Detached mode
			
			# --rm
			# Remove container on exit or daemon exits, whichever happens first.
		
	fi
}

function docker_containers () {
	docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.RunningFor}}\t{{.Labels}}'
}

function docker_up () {
	
	if docker-machine status | grep -q 'Stopped'; then
		echo "starting docker machine"
		docker-machine start default
	
	elif docker-machine status | grep -q 'Running'; then
		echo "already running"
	fi
	
	echo "syncing docker-machine - enviroment"
	eval $(docker-machine env)
	echo "synced"
}

function docker_down () {
	docker-machine stop
}


# Updated @ 01/11/2018
# Changed @ 01/11/2018
# Bug: not able to ssh into alpine.hugo container using this function
# Note: this function did work with every other previous docker container, just something with alpine and hugo.

# function docker_ssh_bash () {
# 	docker exec -it	"${@}" /bin/sh -c "exec /bin/sh";
# }
# 
# function docker_ssh_alpine () {
# 	docker exec -it	"${1}" /bin/ash -c "exec /bin/ash";
# }


function docker_ssh () {

	docker exec -it	"${2}" /bin/"${3}" -c "exec /bin/${3}";
	# docker exec -it	"${2}" /bin/"${2}" -c "exec /bin/${2}";
	# case "${2}" in
	# 	"ash" | "--alpine")
	# 		echo "${3}"
	# 		# docker exec -it "${1}" /bin/ash -c "exec /bin/ash";
	# 		;;
	# 	"bash" | "--bash")
	# 		echo "${3}"
	# 		docker exec -it	"${3}" /bin/"${2}" -c "exec /bin/${2}";
	# 		;;
	# * ) echo " * error - no input command "
	# 	echo "$(docker --version)"
	# 	;;
	# esac
}

function docker_compose_build () {
	
	docker-compose up --force-recreate --build
	
	#build the image with no-cache and tag the image with a name
	#docker build --no-cache -t $1 .
	#docker-compose up -d
}

function docker_list_all_containers () {
	docker ps -a
}

function docker_ip () {
	docker-machine ip default
}

function docker_clean () {
	
	echo '-- removing docker-compose storage --'
	docker-compose stop
	docker-compose rm -rf
	
	echo '-- removing old containers from images --'

    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
	docker rmi -f $(docker images -q -a -f dangling=true)

	#Remove all stopped containers
	docker rm $(docker ps -a | grep Exited | awk '{print $1}')
	#Clean up un-tagged docker images
	docker rmi $(docker images -q --filter "dangling=true")
}


function docker_remove_all_images_and_containers () {
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	# Delete all images
	docker rmi $(docker images -q)
}


function docker_remove_container () {	
	local docker_container_id=${1}
	docker rm --force "${docker_container_id}"
}


function docker_list_all_images () {
	
	#edge case: os.mac bash has errors when accessing the declared global array index value
	#solution: split all bash paramater values into a new local array for each sub function

	#local sub_commands=($(echo "${dockr_paramaters[@]}" | tr ' ' '\n'))
	

	local error_message=$(cat <<-EOF
	error: missing sub command paramater
	example: dockr image --sort
	EOF
	)
	
	if [  ! -z "${docker_subcommands[1]}" ]; then
	
		case "${docker_subcommands[1]}" in
			"sort" | "--sort" | "-a" )
				docker images | awk '{ print $1 }' | tail -n +2 | sort
				;;
			"size" | "--size" | "-s")
				;;
			* ) echo " * error - no input command "
				echo "$(docker --version)"
				# echo "$(docker-machine env)"
			;;
		esac
	elif [ -z "${docker_subcommands[1]}" ]; then
		echo "${error_message}"
	fi

	# if [ "${docker_subcommands[1]}" == "--sort" ]; then
	# 	
	# else
	# 	docker images
	# fi


	# if [ "${sub_commands[1]}" == "--sort" ]; then
	# 	docker images | awk '{ print $1 }' | tail -n +2 | sort
	# else
	# 	docker images
	# fi
	
	
}
