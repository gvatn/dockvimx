 #!/bin/bash
 docker run -it -e DISPLAY --net=host --volume="$HOME/.Xauthority:/root/.Xauthority:rw" cppdev $@