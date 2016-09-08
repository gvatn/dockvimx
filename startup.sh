 #!/bin/bash
 cd /vagrant/neovim
 docker build -t neovim .
 source run-docker.sh bash -l