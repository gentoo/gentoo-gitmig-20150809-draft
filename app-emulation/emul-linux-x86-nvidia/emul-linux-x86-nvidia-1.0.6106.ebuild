# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-nvidia/emul-linux-x86-nvidia-1.0.6106.ebuild,v 1.4 2004/07/13 16:07:31 lv Exp $

inherit eutils

PKG="pkg2"
NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA-Linux-x86_64-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}-${PKG}/usr/lib32"
DESCRIPTION="NVIDIA GLX 32-bit compatibility libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/Linux-x86_64/${NV_V}/${NV_PACKAGE}-${PKG}.run"


LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* amd64"
RESTRICT="nostrip"
IUSE=""

DEPEND="=media-video/nvidia-glx-${PV}
	~app-emulation/emul-linux-x86-xlibs"

export _POSIX2_VERSION="199209"

src_unpack() {
	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG}.run --extract-only
}

src_install() {
	local LIB32_ROOT="/usr/lib32"
	local LIB_ROOT="${LIB32_ROOT}/opengl/nvidia/lib"
	local TLS_ROOT="${LIB_ROOT}/tls"

	cd ${S}
	# The files exist we just have to install them
	exeinto ${LIB_ROOT}
	doexe libGL.so.${PV} \
		  libGLcore.so.${PV} \
		  libnvidia-tls.so.${PV}
	dosym ${LIB_ROOT}/libGL.so.${PV} ${LIB_ROOT}/libGL.so
	dosym ${LIB_ROOT}/libGL.so.${PV} ${LIB_ROOT}/libGL.so.1
	dosym ${LIB_ROOT}/libGLcore.so.${PV} ${LIB_ROOT}/libGLcore.so
	dosym ${LIB_ROOT}/libGLcore.so.${PV} ${LIB_ROOT}/libGLcore.so.1

	# TLS libraries
	dodir ${TLS_ROOT}
	exeinto ${TLS_ROOT}
	doexe tls/libnvidia-tls.so.${PV}
	dosym ${TLS_ROOT}/libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so
	dosym ${TLS_ROOT}/libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so.1
	#dosym ${LIB_ROOT}/tls ${LIB32_ROOT}
}

pkg_postinst() {
	einfo
	einfo "Currently if you need to use 32 bit compatibility libraries"
	einfo "you will need to set the LD_LIBRARY_PATH variable"
	einfo " LD_LIBRARY_PATH=\"/usr/lib32/opengl/nvidia/lib\" <command>"
	einfo
}
