# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/nvidia/nvidia-0.9.5-r3.ebuild,v 1.2 2001/01/16 19:22:32 achim Exp $

S=${WORKDIR}
DESCRIPTION="Accelerated X drivers for NVIDIA based cards"
SRC_URI="ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_GLX-0.9-5.tar.gz
	 ftp://ftp1.detonator.nvidia.com/pub/drivers/english/XFree86_40/0.9-5/NVIDIA_kernel-0.9-5.tar.gz"

DEPEND=">=sys-libs/glibc-2.1.3 >=x11-base/xfree-4.0.1 >=media-libs/glut-3.7"

src_unpack() {
	unpack ${A}
	cd ${S}/NVIDIA_GLX-0.9-5
	cp Makefile Makefile.orig
	sed -e "s:/usr/lib:/usr/X11R6/lib:" -e "s:/sbin/ldconfig::" Makefile.orig > Makefile
	
	cd ${S}/NVIDIA_kernel-0.9-5
	#patching to add devfs support and kernel 2.4.0 fixes
	local x
	for x in patch-2.4.0-PR nvidia_devfs.diff  
	do
		cat ${FILESDIR}/$x | patch -p1
	done
}

src_compile() {                           
  cd ${S}/NVIDIA_kernel-0.9-5
  try make NVdriver
}

src_install() {                               

	#this module requires runtime configuration, as well as frequent reinstalls
	#(as users upgrade kernels).  Therefore, we install the sources and have a
	#special script that handles compilation.  This also allows our script to
	#verify that the OpenGL libraries 'n stuff are installed correctly.

	dodir /usr/src/nvidia
	mv ${S}/NV* ${D}/usr/src/nvidia
	exeinto /usr/src/nvidia
	doexe ${FILESDIR}/nvidia-setup
	doexe ${FILESDIR}/nv_check.sh
}

pkg_postinst() {
	${ROOT}/usr/src/nvidia/nvidia-setup
}




