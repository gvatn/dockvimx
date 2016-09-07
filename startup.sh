 #!/bin/bash
 cd /vagrant/cppdev
 docker build -t cppdev .
 source run-docker.sh bash -l