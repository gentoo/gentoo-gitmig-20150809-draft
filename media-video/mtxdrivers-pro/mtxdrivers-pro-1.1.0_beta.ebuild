# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers-pro/mtxdrivers-pro-1.1.0_beta.ebuild,v 1.2 2004/02/16 01:48:33 spyderous Exp $

inherit matrox

# GL lib version
GL_V="1.3.0"

# Stupid naming scheme requires this, probably only works for betas
MY_PV="${PV/_/-pro-}"
MY_PN="${PN/-pro}"
MY_P="${MY_PN}-rh9.0-v${MY_PV}"
S="${WORKDIR}/${MY_PN}"
DESCRIPTION="Drivers for the Matrox Parhelia and Millenium P650/P750 cards with OpenGL support."
SRC_URI="${MY_P}.tar.gz"

KEYWORDS="x86"

RDEPEND="x11-base/opengl-update
	!media-video/mtxdrivers"

pkg_nofetch() {
	einfo "Matrox requires you e-mail them for the 'pro' version of their drivers"
	einfo "(i.e., the ones with OpenGL support).  If you do not need OpenGL, please"
	einfo "emerge mtxdrivers. Otherwise, e-mail cad-support@matrox.com and request"
	einfo "the Matrox Parhelia drivers with OpenGL support.  Please remember to"
	einfo "download the RH9.0 driver once you are given the site address."
}

src_install() {
	# Install 2D driver and DRM kernel module
	matrox_base_src_install

	dodoc README*

	# Install OpenGL driver, libs, etc.
	local GENTOO_GL_ROOT="/usr/lib/opengl"
	local GENTOO_MTX_ROOT="${GENTOO_GL_ROOT}/mtx"

	dodir ${GENTOO_MTX_ROOT}/extensions; exeinto ${GENTOO_MTX_ROOT}/extensions
	doexe xfree86/${GENTOO_X_VERSION}/libglx.a

	dodir ${GENTOO_MTX_ROOT}/include; insinto ${GENTOO_MTX_ROOT}/include
	doins include/GL/gl.h include/GL/glx.h include/GL/glext.h

	dodir ${GENTOO_MTX_ROOT}/lib; exeinto ${GENTOO_MTX_ROOT}/lib
	doexe lib/libGL.so.${GL_V}
	dosym ${GENTOO_MTX_ROOT}/lib/libGL.so.${GL_V} ${GENTOO_MTX_ROOT}/lib/libGL.so.1
	dosym ${GENTOO_MTX_ROOT}/lib/libGL.so.${GL_V} ${GENTOO_MTX_ROOT}/lib/libGL.so

	# Same as XFree86
	dosym ${GENTOO_GL_ROOT}/xfree/lib/libGL.la ${GENTOO_MTX_ROOT}/lib/libGL.la
}

pkg_postinst() {
	# modules-update, maybe some info on busmastering
	matrox_base_pkg_postinst

	# Don't run opengl-update for them. Tell them how, instead. (spyderous)
	einfo "To switch to Matrox OpenGL, run \"opengl-update mtx\""
}
