# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/nvidia/nvidia-0.9.4-r1.ebuild,v 1.2 2000/08/13 03:10:13 drobbins Exp $

P=nvidia-0.9-4
A="NVIDIA_GLX-0.9-4.xfree401.tar.gz NVIDIA_kernel-0.9-4.tar.gz"
S=${WORKDIR}
CATEGORY="x11-base"
DESCRIPTION="Accelerated X drivers for NVIDIA based cards"
SRC_URI="ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-4/NVIDIA_GLX-0.9-4.xfree401.tar.gz
	 ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-4/NVIDIA_kernel-0.9-4.tar.gz"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}/NVIDIA_kernel-0.9-4
  make NVdriver
}

src_install() {                               
  cd ${S}/NVIDIA_kernel-0.9-4
  insinto /lib/modules/current/misc
  doins NVdriver
  dodir /usr/lib
  dodir /usr/X11R6/lib/modules/drivers
  dodir /usr/X11R6/lib/modules/extensions
  cd ${S}/NVIDIA_GLX-0.9-4.1
  make ROOT=${D} install
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
	    mv ${ROOT}/$i ${ROOT}/$i.nvidia-0.9-4
	fi
    done
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
	if [ -f "${ROOT}/$i.nvidia-0.9-4" ]
	then
	    echo $i
	    mv ${ROOT}/$i.nvidia-0.9-4 ${ROOT}/$i
	fi
    done
}



