# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-nvidia/emul-linux-x86-nvidia-1.0.6106-r1.ebuild,v 1.2 2004/07/19 02:59:34 lv Exp $

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

DEPEND=">=media-video/nvidia-glx-${PV}-r1
	>=app-emulation/emul-linux-x86-xlibs-1.1-r1"

export _POSIX2_VERSION="199209"

src_unpack() {
	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG}.run --extract-only
}

src_install() {
	local LIB32_ROOT="/usr/lib32"
	local LIB_ROOT="${LIB32_ROOT}/opengl/nvidia/lib"
	local TLS_ROOT="${LIB32_ROOT}/opengl/nvidia/tls"

	cd ${S}
	# The files exist we just have to install them
	exeinto ${LIB_ROOT}
	doexe libGL.so.${PV} \
		  libGLcore.so.${PV} \
		  libnvidia-tls.so.${PV}
	dosym libGL.so.${PV} ${LIB_ROOT}/libGL.so
	dosym libGL.so.${PV} ${LIB_ROOT}/libGL.so.1
	dosym libGLcore.so.${PV} ${LIB_ROOT}/libGLcore.so
	dosym libGLcore.so.${PV} ${LIB_ROOT}/libGLcore.so.1
	dosym libnvidia-tls.so.${PV} ${LIB_ROOT}/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${LIB_ROOT}/libnvidia-tls.so.1

	# TLS libraries
	# not sure we need these as glibc in emul-linux-x86-baselibs is non-nptl
	dodir ${TLS_ROOT}
	exeinto ${TLS_ROOT}
	doexe tls/libnvidia-tls.so.${PV}
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so
	dosym libnvidia-tls.so.${PV} ${TLS_ROOT}/libnvidia-tls.so.1
	#dosym ${LIB_ROOT}/tls ${LIB32_ROOT}
}

pkg_postinst() {
	# Setup nvidia opengl implementation
	if [ "${ROOT}" = "/" ]
	then
		/usr/sbin/opengl-update nvidia
	fi
}
