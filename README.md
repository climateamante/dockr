# Dockr: ![image-developer-tool-app-icon](https://drive.google.com/uc?id=1GVXPsTf3VRUTf5vmjov9MocGK0eCCSsu) +  ![image-developer-bash-cli-terminal-command-icon](https://drive.google.com/uc?id=1IHoZpyD1qkALP9CAwIlTaZ9eAEykEtQJ) =  ![image-docker-whale](https://drive.google.com/uc?id=1QUpvgF6FNN-u1xcTLjy8dihfG_uL0alI) #

### Bash CLI Helper Tool For Docker ###
 > `dockr` is a set of scripts and helper tools to avoid remembering complex docker commands


- current: `0.1.4` | 06.11.2018
- previous: `0.1.3` | 01.18.2018


### Reference: ###

* _Why Not Python?_

> Not every `docker` environment or remote server will have or want to include `python`. When possible, every attempt is kept in maintaining portability, ( e.g: ash, bash, alpine, etc ).  No `perl`, `python` or verbose code. Intended to be  readable and modified for different use cases.


### Dependencies: ###
 - `awk`,`grep`,`head`,`sed`,`sort`,`tail`
 - tested with: `bash` 3.2.57

### Features Updated: ###

 - command: ``dockr images --sort``
	> list all local docker images alphanumerically


##### TODO #####

- [ ] TODO: refactor process into a proper CLI tool with testing
- [ ] TODO: create documentation and --help --version commands
- [ ] TODO: ( Feature/Function )
- [x] Able to delete containers via ``dockr remove container_id``
- [ ] TODO: Feature
	> Should be able to do the same and search for images: ``dockr remove image image_id``

