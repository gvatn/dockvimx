 #!/bin/bash
 docker run -it \
 	-e DISPLAY \
 	--net=host \
 	-v="$HOME/.Xauthority:/root/.Xauthority:rw" \
 	-v="/vagrant/neovim/init.vim:/root/.config/nvim/init.vim" \
 	neovim $@