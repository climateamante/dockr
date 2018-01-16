# -- Docker Functions To Review And Update Into Future Files -- #

# function docker_close_containers () {
# 	
# 	local docker_close_subcommand="${1}"
# 
# 	if [ "${docker_close_subcommand}" == "--all" ];
#  	then
# 		docker stop $(docker ps -a -q);
# 		
# 	elif [ ! -z "${docker_close_subcommand}" ];
# 	then	
# 		local docker_container_id="${docker_close_subcommand}"
# 		docker stop "${docker_container_id}";
# 		
# 	elif [ -z "${docker_close_subcommand}" ];
# 	then
# 		echo 'error: no container id passed'
# 		echo 'exmaple: dockr close f570b81b2a4e'
# 		echo 'tip: to close all running containers'
# 		echo 'example: dockr close --all'
# 	fi
	
	#docker rm -v $(docker ps -a -q)
	# docker rm $(docker ps -a -q -f "status=exited*")
	#	echo 'containers removed'
# }

# function docker_ssh () {
	# if docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash" >/dev/null; then
	# 
	# 	docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash"
	# 
	# else
	#     docker exec -it $1 /bin/ash -c "export TERM=xterm; exec ash"
	# fi

}

# function docker_ssh () {
# 	
# 	if docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash" >/dev/null; then
# 
# 		docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash"
# 
# 	else
# 	    docker exec -it $1 /bin/ash -c "export TERM=xterm; exec ash"
# 	fi
# 
# }


# 
# 
# 
# docker_remove(){
# 	docker rmi $1
# }
# 
# 
# 
# 
# 
# 
# docker_save(){
# 	#save image to file
# 	docker ps -a
# 	docker save $1 > image.tar
# 
# 	#load from file
# 	docker load < image.tar
# }
# 
# docker_export(){
# 	#export container to file
# 	#docker ps -a
# 	echo "backing up container $1"
# 	#docker export $1 | gzip > $1.$(date "+%Y.%m.%d.%H%M%S").tar.gz
# 	docker export $1 > $1.$(date "+%Y.%m.%d.%H%M%S").tar
# 	echo "backup complete"
# }
# 
# docker_import(){
# 	#import from file
# 	tar -c $1 | docker import - $2
# }
# 
# docker_id(){
# 	docker inspect --format='{{.ID}}' $(docker ps -aq --no-trunc)
# }
# 
# docker_name(){
# 	docker inspect --format='{{.Name}}' $(docker ps -aq --no-trunc)
# }
# 
# docker_load(){
# 	docker load --input $1
# }
# 
# docker_run_web(){
# 	docker run -p 80:80 -v $(pwd) --name $1 $2
# }
# 
# docker_run(){
# 	docker run -itd -v $(pwd) --name $1 $2
# }
# 
# 
# docker_load(){
# 	gunzip -c $1 | docker load
# }
# 
# 
# docker_clean_volume(){
# 	docker volume rm $(docker volume ls -qf dangling=true)
# }
# 
# 
# docker_copy(){
# 	docker cp $1 $(pwd)
# }
# 
# Dockr Aliases
# alias docker-down=docker_down
# alias docker-ls=docker_list_all_containers
# alias docker-compose-build=docker_compose_build
# alias docker-ip="docker-machine ip default"
# alias docker-clean=docker_clean
# alias docker-remove-all=docker_remove_all_images_and_containers
# 
# alias docker-load=docker_load
# 
# alias docker-clean-volume=docker_clean_volume
# 
# ### DEBUG 
# 
# alias docker-images-clean="docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')"
# 
# alias docker-env="eval $(docker-machine env)"
# alias docker-boot="eval $(docker-machine env)"
# 
# 
# 
# 
# alias docker-status="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Status}}'"
# alias docker-start="docker-machine start"
# alias docker-stop="docker-machine stop"
# 
# 
# alias docker-network-reset="docker network rm `docker network ls -q`"
# 
# alias docker-up=docker_up
# 
# alias docker-remove=docker_remove
# 
# alias docker-save=docker_save
# alias docker-export=docker_export
# alias docker-import=docker_import
# 
# alias docker-id=docker_id
# alias docker-name=docker_name

# alias docker-load=docker_load
# alias docker-run=docker_run
# alias docker-copy=docker_copy
# 
# alias dc-up="docker-compose up -d"
# alias dc-start="docker-compose up -d"
# 
# alias dc-down="docker-compose down"
# alias dc-stop="docker-compose down"
# 
# alias dc-ps="docker-compose ps"
