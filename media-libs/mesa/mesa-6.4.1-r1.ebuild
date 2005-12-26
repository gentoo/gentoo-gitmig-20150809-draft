# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-6.4.1-r1.ebuild,v 1.3 2005/12/26 13:49:10 stefaan Exp $

inherit eutils toolchain-funcs multilib

# Arches that need to define their own sets of DRI drivers, please do so in
# a variable up here, and use that variable below. This helps us to separate the
# data from the code.
DRI_DRIVERS_SPARC="ffb mach64 mga radeon savage"

OPENGL_DIR="xorg-x11"

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV}"
MY_SRC_P="${MY_PN}Lib-${PV}"
DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/mesa3d/${MY_SRC_P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~sh ~sparc ~x86"
IUSE="motif"

RDEPEND="dev-libs/expat
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXi
	x11-libs/libXmu
	>=x11-libs/libdrm-1.0.5
	x11-libs/libICE
	app-admin/eselect-opengl
	motif? ( virtual/motif )
	!<=x11-base/xorg-x11-6.9"
DEPEND="${RDEPEND}
	x11-misc/makedepend
	x11-proto/xf86vidmodeproto
	>=x11-proto/glproto-1.4-r1
	motif? ( x11-proto/printproto )"

PROVIDE="virtual/opengl virtual/glu"

S="${WORKDIR}/${MY_P}"

# Think about: ggi, svga, fbcon, no-X configs

pkg_setup() {
	if [[ ${KERNEL} == "FreeBSD" ]]; then
		CONFIG="freebsd"
	elif use x86; then
		CONFIG="linux-dri-x86"
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

	epatch ${FILESDIR}/makedepend-location.patch
	epatch ${FILESDIR}/6.4-dont-install-gles-headers.patch
	# Don't change it but make it configurable and set it below - Herbs
	#epatch ${FILESDIR}/change-default-dri-driver-dir.patch
	epatch ${FILESDIR}/configurable-dri-dir.patch
	epatch ${FILESDIR}/6.4-multilib-fix.patch
	epatch ${FILESDIR}/${PV}-amd64-include-assyntax.patch

	# Set default dri drivers directory
	echo "DRI_DRIVER_DIR = /usr/$(get_libdir)/xorg/modules/dri" >> ${HOSTCONF}

	# Set up linux-dri configs
	if use sparc; then
		einfo "Define the sparc DRI drivers."
		echo "DRI_DIRS = ${DRI_DRIVERS_SPARC}" >> ${HOSTCONF}
		einfo "Explicitly note that sparc assembly code is not working."
		echo "ASM_FLAGS =" >> ${HOSTCONF}
		echo "ASM_SOURCES =" >> ${HOSTCONF}
	fi

	# Kill this; we don't want /usr/X11R6/lib ever to be searched in this
	# build.
	echo "EXTRA_LIB_PATH =" >> ${HOSTCONF}

	echo "OPT_FLAGS = ${CFLAGS}" >> ${HOSTCONF}
	echo "CC = $(tc-getCC)" >> ${HOSTCONF}
	echo "CXX = $(tc-getCXX)" >> ${HOSTCONF}
	# bug #110840 - Build with PIC, since it hasn't been shown to slow it down
	echo "PIC_FLAGS = -fPIC" >> ${HOSTCONF}

	# Removed glut, since we have separate freeglut/glut ebuilds
	# Remove EGL, since Brian Paul says it's not ready for a release
	echo "SRC_DIRS = glx/x11 mesa glu glw" >> ${HOSTCONF}

	# Get rid of glut includes
	rm -f ${S}/include/GL/glut*h

	# r200 breaks without this, since it's the only EGL-enabled driver so far
	echo "USING_EGL = 0" >> ${HOSTCONF}

	# Don't build EGL demos. EGL isn't ready for release, plus they produce a
	# circular dependency with glut.
	echo "PROGRAM_DIRS =" >> ${HOSTCONF}

	# Documented in configs/default
	if use motif; then
		# Add -lXm
		echo "GLW_LIB_DEPS += -lXm" >> ${HOSTCONF}
		# Add GLwMDrawA.c
		echo "GLW_SOURCES += GLwMDrawA.c" >> ${HOSTCONF}
	fi
}

src_compile() {
	emake -j1 ${CONFIG} || die "Build failed"
}

src_install() {
	dodir /usr
	make \
		DESTDIR=${D}/usr \
		INCLUDE_DIR=${D}/usr/include \
		LIB_DIR=${D}/usr/$(get_libdir) \
		install || die "Installation failed"

	##
	# Install the actual drivers --- 'make install' doesn't install them
	# anywhere.
	dodir /usr/$(get_libdir)/xorg/modules/dri
	exeinto /usr/$(get_libdir)/xorg/modules/dri
	einfo "Installing drivers to ${EXEDESTTREE}."
	find ${S}/lib* -name '*_dri.so' | xargs doexe

	insinto /usr/include/GL
	doins ${S}/src/glw/GLwDrawA.h
	if use motif; then
		doins ${S}/src/glw/GLwMDrawA.h
	fi

	fix_opengl_symlinks
	dynamic_libgl_install

	# Install libtool archives
	insinto /usr/$(get_libdir)
	# (#67729) Needs to be lib, not $(get_libdir)
	doins ${FILESDIR}/lib/libGLU.la
	insinto /usr/$(get_libdir)/opengl/xorg-x11/lib
	doins ${FILESDIR}/lib/libGL.la

	# Create the two-number versioned libs (.so.#.#), since only .so.# and
	# .so.#.#.# were made
	dosym libGLU.so.1.3.060401 /usr/$(get_libdir)/libGLU.so.1.3
	dosym libGLw.so.1.0.0 /usr/$(get_libdir)/libGLw.so.1.0

	# libGLU doesn't get the plain .so symlink either
	dosym libGLU.so.1 /usr/$(get_libdir)/libGLU.so

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
		-name libGL\.* -type l); do
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
		eselect opengl set --use-old ${OPENGL_DIR}
}
