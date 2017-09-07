#!/bin/bash

source version

echo \$verion = $verion
echo \$img_name = $img_name




docker container run -v /mnt:/mnt -v `pwd`/output:/output ${img_name}

