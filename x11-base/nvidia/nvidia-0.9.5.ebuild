# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/nvidia/nvidia-0.9.5.ebuild,v 1.2 2000/09/15 20:09:29 drobbins Exp $

A="NVIDIA_GLX-0.9-5.tar.gz NVIDIA_kernel-0.9-5.tar.gz"
S=${WORKDIR}
DESCRIPTION="Accelerated X drivers for NVIDIA based cards"
SRC_URI="ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_GLX-0.9-5.tar.gz
	 ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz"

src_unpack() {
  unpack ${A}
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
  dodir /dev
  for i in 0 1 2 3 4; do
    mknod ${D}/dev/nvidia$i c 195 $i
  done
  mknod ${D}/dev/nvidiactl c 195 255
  chmod 0666 ${D}/dev/nvidia*  
}

pkg_preinst() {

   . ${ROOT}/etc/rc.d/config/functions

   einfo "Making backups..."
   for i in /usr/X11R6/lib/modules/extensions/libGLcore.a \
	    /usr/X11R6/lib/modules/extensions/libglx.a \
	    /usr/lib/libGL.so \
	    /usr/X11R6/lib/libGL.so* \
	    /usr/X11R6/lib/libGLcore.so*
    do
	if [ -f "${ROOT}/$i" ]
	then
	    echo $i
	    mv ${ROOT}/$i ${ROOT}/$i.nvidia-0.9-5
	fi
    done
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

pkg_postrm() {

   . ${ROOT}/etc/rc.d/config/functions

   einfo "Restoring backups..."
   for i in /usr/X11R6/lib/modules/extensions/libGLcore.a \
	    /usr/X11R6/lib/modules/extensions/libglx.a \
	    /usr/lib/libGL.so \
	    /usr/X11R6/lib/libGL.so* \
	    /usr/X11R6/lib/libGLcore.so*
    do
	if [ -f "${ROOT}/$i.nvidia-0.9-5" ]
	then
	    echo $i
	    mv ${ROOT}/$i.nvidia-0.9-5 ${ROOT}/$i
	fi
    done
}




