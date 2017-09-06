#!/bin/bash

verion=0.5
img_name=rhel_builder


docker build -t ${img_name}:1 -t ${img_name}:latest .
#docker container run -v /mnt:/mnt -v `pwd`/output:/output ${img_name}

