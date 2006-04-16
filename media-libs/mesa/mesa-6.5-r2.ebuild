# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-6.5-r2.ebuild,v 1.3 2006/04/16 20:01:31 spyderous Exp $

inherit eutils toolchain-funcs multilib flag-o-matic portability

OPENGL_DIR="xorg-x11"

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV}"
MY_SRC_P="${MY_PN}Lib-${PV}"
DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/mesa3d/${MY_SRC_P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE_VIDEO_CARDS="
	video_cards_ati
	video_cards_i810
	video_cards_mga
	video_cards_none
	video_cards_s3virge
	video_cards_savage
	video_cards_sis
	video_cards_sunffb
	video_cards_tdfx
	video_cards_trident
	video_cards_via"
IUSE="${IUSE_VIDEO_CARDS}
	debug
	motif"

RDEPEND="dev-libs/expat
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXi
	x11-libs/libXmu
	>=x11-libs/libdrm-2.0.1
	x11-libs/libICE
	app-admin/eselect-opengl
	motif? ( virtual/motif )
	!<=x11-base/xorg-x11-6.9"
DEPEND="${RDEPEND}
	x11-misc/makedepend
	x11-proto/inputproto
	x11-proto/xextproto
	!hppa? ( x11-proto/xf86driproto )
	x11-proto/xf86vidmodeproto
	>=x11-proto/glproto-1.4-r1
	motif? ( x11-proto/printproto )"

PROVIDE="virtual/opengl virtual/glu"

S="${WORKDIR}/${MY_P}"

# Think about: ggi, svga, fbcon, no-X configs

if use debug; then
	if ! has splitdebug ${FEATURES}; then
		RESTRICT="${RESTRICT} nostrip"
	fi
fi

pkg_setup() {
	if use debug; then
		strip-flags
		append-flags -g
	fi

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

	epatch ${FILESDIR}/6.4-dont-install-gles-headers.patch
	epatch ${FILESDIR}/change-default-dri-driver-dir-X7.1.patch
	epatch ${FILESDIR}/6.4-multilib-fix.patch
	epatch ${FILESDIR}/6.5-re-order-context-destruction.patch

	# Don't compile debug code with USE=-debug - bug #125004
	if ! use debug; then
	   einfo "Removing DO_DEBUG defs in dri drivers..."
	   find src/mesa/drivers/dri -name *.[hc] -exec egrep -l "\#define\W+DO_DEBUG\W+1" {} \; | xargs sed -i -re "s/\#define\W+DO_DEBUG\W+1/\#define DO_DEBUG 0/" ;
	fi

	# Set default dri drivers directory
	echo "DEFINES += -DDEFAULT_DRIVER_DIR='\"/usr/$(get_libdir)/dri\"'" >> ${HOSTCONF}

	# Configurable DRI drivers
	if use video_cards_ati; then
		add_drivers mach64 r128 radeon r200 r300
	fi
	if use video_cards_i810; then
		add_drivers i810 i915
	fi
	if use video_cards_mga; then
		add_drivers mga
	fi
	if use video_cards_s3virge; then
		add_drivers s3v
	fi
	if use video_cards_savage; then
		add_drivers savage
	fi
	if use video_cards_sis; then
		add_drivers sis
	fi
	if use video_cards_sunffb; then
		add_drivers ffb
	fi
	if use video_cards_tdfx; then
		add_drivers tdfx
	fi
	if use video_cards_trident; then
		add_drivers trident
	fi
	if use video_cards_via; then
		add_drivers unichrome
	fi

	# Defaults based on X.Org 6.9, with some changes
	if [[ ! -n "${VIDEO_CARDS}" ]]; then
		if use alpha; then
			add_drivers mga tdfx r128 r200 r300 radeon
		elif use amd64; then
			add_drivers i915 mga r128 r200 r300 radeon tdfx
		elif use arm; then
			add_drivers mga r128 r200 r300 radeon
		elif use hppa; then
			# no accelerated 3D on hppa
			true
		elif use ia64; then
			add_drivers mach64 mga r128 r200 r300 radeon tdfx unichrome
		elif use mips; then
			# no accelerated 3D on mips
			true
		elif use ppc; then
			add_drivers mach64 mga r128 r200 r300 radeon tdfx
		elif use ppc64; then
			add_drivers mga r128 r200 r300 radeon
		elif use sparc; then
			add_drivers ffb mach64
		elif use x86; then
			add_drivers i810 i915 mach64 mga r128 r200 r300 radeon s3v savage \
				sis tdfx trident unichrome
		fi
	fi

	# Set drivers to everything on which we ran add_drivers()
	echo "DRI_DIRS = ${DRI_DRIVERS}" >> ${HOSTCONF}

	if use sparc; then
		einfo "Sparc assembly code is not working; deactivating"
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
	dodir /usr/$(get_libdir)/dri
	exeinto /usr/$(get_libdir)/dri
	ebegin "Installing drivers to ${EXEDESTTREE}"
	find ${S}/lib* -name '*_dri.so' | xargs doexe
	eend

	if ! use motif; then
		rm ${D}/usr/include/GL/GLwMDrawA.h
	fi

	# Don't install private headers
	rm ${D}/usr/include/GL/GLw*P.h

	fix_opengl_symlinks
	dynamic_libgl_install

	# Install libtool archives
	insinto /usr/$(get_libdir)
	# (#67729) Needs to be lib, not $(get_libdir)
	doins ${FILESDIR}/lib/libGLU.la
	insinto /usr/$(get_libdir)/opengl/xorg-x11/lib
	doins ${FILESDIR}/lib/libGL.la

	# On *BSD libcs dlopen() and similar functions are present directly in
	# libc.so and does not require linking to libdl. portability eclass takes
	# care of finding the needed library (if needed) witht the dlopen_lib
	# function.
	sed -i -e 's:-ldl:'$(dlopen_lib)':g' \
		${D}/usr/$(get_libdir)/libGLU.la \
		${D}/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.la

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
	if [[ ${CHOST} == *-freebsd* ]]; then
		# FreeBSD doesn't use major.minor versioning, so the library is only
		# libGL.so.1 and no libGL.so.1.2 is ever used there, thus only create
		# libGL.so symlink and leave libGL.so.1 being the real thing
		dosym libGL.so.1 /usr/$(get_libdir)/libGL.so
	else
		dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so
		dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so.1
	fi
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

add_drivers() {
	DRI_DRIVERS="${DRI_DRIVERS} $@"
}
