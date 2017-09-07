#!/bin/bash

RHEL_DIR=/rhel

mkdir -p ${RHEL_DIR}/var/lib/rpm
rpm --root ${RHEL_DIR} --initdb

BASE="/mnt/Packages"

rpm --root ${RHEL_DIR} -ihv ${BASE}/redhat-release*

mkdir -p evince ${RHEL_DIR}/etc/yum.repos.d/
cp -v /scripts/rhel-dvd.repo ${RHEL_DIR}/etc/yum.repos.d/
cat ${RHEL_DIR}/etc/yum.repos.d/rhel-dvd.repo

yum -y --installroot=${RHEL_DIR} install yum rpm

rpm --root=${RHEL_DIR} --import /mnt/RPM-GPG-KEY-redhat-release

echo "updating"
yum -y --installroot=${RHEL_DIR} update

echo "installing software"
yum -y --installroot=${RHEL_DIR} localinstall ${BASE}/unzip*rpm
yum -y --installroot=${RHEL_DIR} clean all

echo "RHEL Docker Image" > ${RHEL_DIR}/etc/motd

VERSION=$(awk  '{print $7'} ${RHEL_DIR}/etc/redhat-release)
TYPE=$(awk -F: '{print $7'} ${RHEL_DIR}/etc/system-release-cpe)

echo "cleanup"
rm ${RHEL_DIR}/etc/yum.repos.d/rhel-dvd.repo

echo "creating image tarball"
tar -C ${RHEL_DIR} -cpf /output/rhel_base.tgz .

echo ""
echo "---------------------------------------------------------"
echo ""
echo "run --> docker image import - rhel${VERSION}-${TYPE} < output/rhel_base.tgz"
echo ""
