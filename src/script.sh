#!/bin/bash

RHEL_DIR=/rhel
JEDI=0

mkdir -p ${RHEL_DIR}/var/lib/rpm
rpm --root ${RHEL_DIR} --initdb

if [ -f "/mnt/JEDI.tgz" ]; then
    BASE="/mnt/Packages/rhel-x86_64-server-6/getPackage"
else
    BASE="/mnt/Packages"
fi

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

echo "RHEL Docker Image" > ${RHEL_DIR}/etc/motd

##echo "Something Something JEDI"
##tar -C ${RHEL_DIR}/opt -xpf /scripts/JEDI.tgz
##chroot ${RHEL_DIR} /opt/JEDI/Scripts/config.Lockdown -s /opt/JEDI/config

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
