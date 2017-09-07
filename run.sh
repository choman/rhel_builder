#!/bin/bash

source version

echo \$verion = $verion
echo \$img_name = $img_name

iso=~/Downloads/ISO/rhel-workstation-7.4-x86_64-dvd.iso


docker container run -v /mnt:/mnt -v `pwd`/output:/output ${img_name}

