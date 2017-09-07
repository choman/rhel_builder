#!/bin/bash

source version

docker build -t ${img_name}:1 -t ${img_name}:latest .

