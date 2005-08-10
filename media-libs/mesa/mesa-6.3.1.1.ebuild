# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-6.3.1.1.ebuild,v 1.7 2005/08/10 21:36:40 spyderous Exp $

inherit eutils toolchain-funcs

OPENGL_DIR="xorg-x11"

LIBDRM_PV="1.0.1"
LIBDRM_P="libdrm-${LIBDRM_PV}"

MY_PN=${PN/m/M}
MY_P=${MY_PN}-${PV}
DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"
SRC_URI="http://xorg.freedesktop.org/extras/${MY_P}.tar.gz
	http://xorg.freedesktop.org/extras/${LIBDRM_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="motif"

RDEPEND="dev-libs/expat
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXi
	x11-libs/libXmu
	>=x11-base/opengl-update-2.2.2
	motif? ( virtual/motif )"
DEPEND="${RDEPEND}
	x11-misc/makedepend
	>=x11-proto/glproto-1.4-r1"

PROVIDE="virtual/opengl virtual/glu"

S="${WORKDIR}/${MY_P}"

# Think about: ggi, svga, fbcon, no-X configs

pkg_setup() {
	if use x86; then
		CONFIG="linux-dri-x86"
	# amd64 people need to look at this file to deal with lib64 issues, unless
	# they're fine with hardcoded lib64.
	elif use amd64; then
		CONFIG="linux-dri-x86-64"
	elif use ppc; then
		CONFIG="linux-dri-ppc"
	else
		CONFIG="linux-dri"
	fi
}

src_unpack() {
	HOSTCONF="${S}/configs/${CONFIG}"

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/fix-xthreads-location.patch
	epatch ${FILESDIR}/use-xthreads.patch

	# Set up linux-dri configs
	echo "OPT_FLAGS = ${CFLAGS}" >> ${HOSTCONF}
	if use sparc; then
		echo "ASM_FLAGS = -DUSE_SPARC_ASM" >> ${HOSTCONF}
		echo "ASM_SOURCES = \$(SPARC_SOURCES) \$(SPARC_API)" >> ${HOSTCONF}
		echo "DRIVER_DIRS = " >> ${HOSTCONF}
	fi
	echo "CC = $(tc-getCC)" >> ${HOSTCONF}
	echo "CXX = $(tc-getCXX)" >> ${HOSTCONF}
	echo "DRM_SOURCE_PATH=\$(TOP)/../${LIBDRM_P}" >> ${HOSTCONF}

	# Removed glut, since we have separate freeglut/glut ebuilds
	echo "SRC_DIRS = glx/x11 mesa glu glw" >> ${HOSTCONF}

	# Documented in configs/default
	if use motif; then
		# Add -lXm
		echo "GLW_LIB_DEPS = -L\$(LIB_DIR) -l\$(GL_LIB) \$(EXTRA_LIB_PATH) -lXt -lX11 -lXm" >> ${HOSTCONF}
		# Add GLwMDrawA.c
		echo "GLW_SOURCES = GLwDrawA.c GLwMDrawA.c" >> ${HOSTCONF}
	fi
}

src_compile() {
	make ${CONFIG} || die "Build failed"
}

src_install() {
	dodir /usr
	make DESTDIR=${D}/usr install || die "Installation failed"
	fix_opengl_symlinks
	dynamic_libgl_install

	# Install libtool archives
	insinto /usr/$(get_libdir)
	# (#67729) Needs to be lib, not $(get_libdir)
	doins ${FILESDIR}/lib/*.la

	# Create the two-number versioned libs (.so.#.#), since only .so.# and
	# .so.#.#.# were made
	dosym libGLU.so.1.3.060301 /usr/lib/libGLU.so.1.3
	dosym libGLw.so.1.0.0 /usr/lib/libGLw.so.1.0
	dosym libOSMesa.so.6.3.060301 /usr/lib/libOSMesa.so.6.3

	# Figure out why libGL.so.1.5 is built (directfb), and why it's linked to
	# as the default libGL.so.1
}

pkg_postinst() {
	switch_opengl_implem
}

fix_opengl_symlinks() {
	# Remove invalid symlinks
	local LINK
	for LINK in $(find ${D}/usr/$(get_libdir) \
		-name libGL.* -type l); do
		rm -f ${LINK}
	done
	# Create required symlinks
	dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so
	dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so.1
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/{lib,extensions,include}
		local x=""
		for x in ${D}/usr/$(get_libdir)/libGL.so* \
			${D}/usr/$(get_libdir)/libGL.la \
			${D}/usr/$(get_libdir)/libGL.a; do
			if [ -f ${x} -o -L ${x} ]; then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${OPENGL_DIR}/lib
			fi
		done
		# glext.h added for #54984
		for x in ${D}/usr/include/GL/{gl.h,glx.h,glext.h,glxext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${OPENGL_DIR}/include
			fi
		done
	eend 0
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		local opengl_implem="$(${ROOT}/usr/sbin/opengl-update --get-implementation)"
		${ROOT}/usr/sbin/opengl-update --use-old ${OPENGL_DIR}
}
