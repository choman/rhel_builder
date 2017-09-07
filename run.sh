#!/bin/bash

source version

echo \$verion = $verion
echo \$img_name = $img_name


if [ ! -f "/mnt/RPM-GPG-KEY-redhat-release" ]; then 
    echo ""
    echo "ERROR: Unable to locate RHEL distro, please mount to /mnt"
    echo ""
    exit
fi


time docker container run --rm -v /mnt:/mnt -v `pwd`/output:/output ${img_name}

