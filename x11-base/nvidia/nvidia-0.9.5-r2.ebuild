# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/nvidia/nvidia-0.9.5-r2.ebuild,v 1.1 2000/10/30 20:08:26 achim Exp $

A="NVIDIA_GLX-0.9-5.tar.gz NVIDIA_kernel-0.9-5.tar.gz"
S=${WORKDIR}
DESCRIPTION="Accelerated X drivers for NVIDIA based cards"
SRC_URI="ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_GLX-0.9-5.tar.gz
	 ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz"

src_unpack() {
  unpack ${A}
  cd ${S}/NVIDIA_GLX-0.9-5
  cp Makefile Makefile.orig
  sed -e "s:/usr/lib:/usr/X11R6/lib:" \
      -e "s:/sbin/ldconfig::" Makefile.orig > Makefile
}

src_compile() {                           
  cd ${S}/NVIDIA_kernel-0.9-5
  try make NVdriver
}

src_install() {                               
  cd ${S}/NVIDIA_kernel-0.9-5
  insinto /lib/modules/current/misc
  doins NVdriver
  dodir /usr/lib
  dodir /usr/X11R6/lib/modules/drivers
  dodir /usr/X11R6/lib/modules/extensions
  cd ${S}/NVIDIA_GLX-0.9-5
  try make ROOT=${D} install
  preplib /usr/X11R6
  dodir /dev
  for i in 0 1 2 3 4; do
    mknod ${D}/dev/nvidia$i c 195 $i
  done
  mknod ${D}/dev/nvidiactl c 195 255
  chmod 0666 ${D}/dev/nvidia*  
}


pkg_config() {
  if [ "${ROOT}" == "/" ] ; then
    modconf="/etc/modules/"`uname -r`
    if [ -f $modconf ] ; then
        modtmp=/tmp/conf$$
        sed '/^alias.*char-major-.*NVdriver/d' < $modconf > $modtmp
        echo "alias char-major-195 NVdriver" >> $modtmp
        mv $modtmp $modconf  
    fi
  fi
}






