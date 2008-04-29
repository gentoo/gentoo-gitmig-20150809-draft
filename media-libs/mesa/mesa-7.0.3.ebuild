# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-7.0.3.ebuild,v 1.3 2008/04/29 07:39:23 hanno Exp $

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV/_/-}"
MY_SRC_P="${MY_PN}Lib-${PV/_/-}"

GIT=
if [[ $PV = *_rc* ]]; then
	SRC_URI="http://www.mesa3d.org/beta/${MY_SRC_P}.tar.gz"
elif [[ $PV = 9999 ]]; then
	SRC_URI=""
	GIT="git"
	EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/mesa"
else
	SRC_URI="mirror://sourceforge/mesa3d/${MY_SRC_P}.tar.bz2"
fi

inherit eutils toolchain-funcs multilib flag-o-matic ${GIT} portability versionator

OPENGL_DIR="xorg-x11"

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE_VIDEO_CARDS="
	video_cards_i810
	video_cards_mach64
	video_cards_mga
	video_cards_none
	video_cards_r128
	video_cards_radeon
	video_cards_s3virge
	video_cards_savage
	video_cards_sis
	video_cards_sunffb
	video_cards_tdfx
	video_cards_trident
	video_cards_via"
IUSE="${IUSE_VIDEO_CARDS}
	debug
	doc
	pic
	motif
	nptl
	xcb
	kernel_FreeBSD"

RDEPEND="app-admin/eselect-opengl
	dev-libs/expat
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXdamage
	>=x11-libs/libdrm-2.3.0
	x11-libs/libICE
	motif? ( virtual/motif )
	doc? ( app-doc/opengl-manpages )
	!<=x11-base/xorg-x11-6.9
	xcb? ( x11-libs/libxcb )"
DEPEND="${RDEPEND}
	!<=x11-proto/xf86driproto-2.0.3
	dev-util/pkgconfig
	x11-misc/makedepend
	x11-proto/inputproto
	x11-proto/xextproto
	!hppa? ( x11-proto/xf86driproto )
	x11-proto/xf86vidmodeproto
	>=x11-proto/glproto-1.4.8
	motif? ( x11-proto/printproto )"

S="${WORKDIR}/${MY_P}"

# Think about: ggi, svga, fbcon, no-X configs

pkg_setup() {
	if use xcb; then
		if ! built_with_use x11-libs/libX11 xcb; then
			msg="You must build libX11 with xcb enabled."
			eerror ${msg}
			die ${msg}
		fi
	fi

	if use debug; then
		strip-flags
		append-flags -g
	fi

	append-flags -fno-strict-aliasing

	# Recommended by upstream. Since people shouldn't be setting this on
	# a system level, we set this in this package to be sure it gets it.
	append-flags -ffast-math

	# gcc 4.2 has buggy ivopts
	if [[ $(gcc-version) = "4.2" ]]; then
		append-flags -fno-ivopts
	fi

	if use x86-fbsd; then
		CONFIG="freebsd-dri-x86"
	elif use amd64-fbsd; then
		CONFIG="freebsd-dri-amd64"
	elif use kernel_FreeBSD; then
		CONFIG="freebsd-dri"
	elif use x86; then
		CONFIG="linux-dri-x86"
	elif use amd64; then
		[[ ${ABI} == "amd64" ]] && CONFIG="linux-dri-x86-64"
		[[ ${ABI} == "x86" ]] && CONFIG="linux-dri-x86"
	elif use ppc; then
		CONFIG="linux-dri-ppc"
	else
		CONFIG="linux-dri"
	fi
}

src_unpack() {
	HOSTCONF="${S}/configs/${CONFIG}"

	if [[ $PV = 9999 ]]; then
		git_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"

	# FreeBSD 6.* doesn't have posix_memalign().
	[[ ${CHOST} == *-freebsd6.* ]] && sed -i -e "s/-DHAVE_POSIX_MEMALIGN//" configs/freebsd{,-dri}

	# Don't compile debug code with USE=-debug - bug #125004
	if ! use debug; then
	   einfo "Removing DO_DEBUG defs in dri drivers..."
	   find src/mesa/drivers/dri -name *.[hc] -exec egrep -l "\#define\W+DO_DEBUG\W+1" {} \; | xargs sed -i -re "s/\#define\W+DO_DEBUG\W+1/\#define DO_DEBUG 0/" ;
	fi

	# Set up libdir
	echo "LIB_DIR = $(get_libdir)" >> "${HOSTCONF}"

	# Set default dri drivers directory
	echo 'DRI_DRIVER_SEARCH_DIR = /usr/$(LIB_DIR)/dri' >> "${HOSTCONF}"

	# Do we want thread-local storage (TLS)?
	if use nptl; then
		echo "ARCH_FLAGS += -DGLX_USE_TLS" >> "${HOSTCONF}"
	fi

	echo "X11_INCLUDES = `pkg-config --cflags-only-I x11`" >> "${HOSTCONF}"
	if use xcb; then
		echo "DEFINES += -DUSE_XCB" >> "${HOSTCONF}"
		echo "X11_INCLUDES += `pkg-config --cflags-only-I xcb` `pkg-config --cflags-only-I x11-xcb` `pkg-config --cflags-only-I xcb-glx`" >> "${HOSTCONF}"
		echo "GL_LIB_DEPS += `pkg-config --libs xcb` `pkg-config --libs x11-xcb` `pkg-config --libs xcb-glx`" >> "${HOSTCONF}"
	fi

	# Configurable DRI drivers
	driver_enable video_cards_i810 i810 i915 i915tex i965
	driver_enable video_cards_mach64 mach64
	driver_enable video_cards_mga mga
	driver_enable video_cards_r128 r128
	driver_enable video_cards_radeon radeon r200 r300
	driver_enable video_cards_s3virge s3v
	driver_enable video_cards_savage savage
	driver_enable video_cards_sis sis
	driver_enable video_cards_sunffb ffb
	driver_enable video_cards_tdfx tdfx
	driver_enable video_cards_trident trident
	driver_enable video_cards_via unichrome

	# Set drivers to everything on which we ran driver_enable()
	echo "DRI_DIRS = ${DRI_DRIVERS}" >> "${HOSTCONF}"

	if use pic; then
		einfo "Deactivating assembly code for pic build"
		echo "ASM_FLAGS =" >> "${HOSTCONF}"
		echo "ASM_SOURCES =" >> "${HOSTCONF}"
		echo "ASM_API =" >> "${HOSTCONF}"
	fi

	if use sparc; then
		einfo "Sparc assembly code is not working; deactivating"
		echo "ASM_FLAGS =" >> "${HOSTCONF}"
		echo "ASM_SOURCES =" >> "${HOSTCONF}"
	fi

	# Replace hardcoded /usr/X11R6 with this
	echo "EXTRA_LIB_PATH = `pkg-config --libs-only-L x11`" >> "${HOSTCONF}"

	echo 'CFLAGS = $(OPT_FLAGS) $(PIC_FLAGS) $(ARCH_FLAGS) $(DEFINES) $(ASM_FLAGS)' >> "${HOSTCONF}"
	echo "OPT_FLAGS = ${CFLAGS}" >> "${HOSTCONF}"
	echo "CC = $(tc-getCC)" >> "${HOSTCONF}"
	echo "CXX = $(tc-getCXX)" >> "${HOSTCONF}"
	# bug #110840 - Build with PIC, since it hasn't been shown to slow it down
	echo "PIC_FLAGS = -fPIC" >> "${HOSTCONF}"

	# Removed glut, since we have separate freeglut/glut ebuilds
	# Remove EGL, since Brian Paul says it's not ready for a release
	echo "SRC_DIRS = glx/x11 mesa glu glw" >> "${HOSTCONF}"

	# Get rid of glut includes
	rm -f "${S}"/include/GL/glut*h

	# Documented in configs/default
	if use motif; then
		# Add -lXm
		echo "GLW_LIB_DEPS += -lXm" >> "${HOSTCONF}"
		# Add GLwMDrawA.c
		echo "GLW_SOURCES += GLwMDrawA.c" >> "${HOSTCONF}"
	fi

	# Shut up pointless warnings
#	echo "MKDEP = gcc -M" >> "${HOSTCONF}"
#	echo "MKDEP_OPTIONS = -MF depend" >> "${HOSTCONF}"
	echo "MKDEP_OPTIONS = -fdepend -I$(gcc-config -L)/include" >> "${HOSTCONF}"
	echo "INSTALL_DIR = /usr" >> "${HOSTCONF}"
	echo 'DRI_DRIVER_INSTALL_DIR = /usr/$(LIB_DIR)/dri' >> "${HOSTCONF}"
}

src_compile() {
	emake -j1 ${CONFIG} || die "Build failed"
}

src_install() {
	dodir /usr
	emake -j1 \
		DESTDIR="${D}" \
		install || die "Installation failed"

	if ! use motif; then
		rm "${D}"/usr/include/GL/GLwMDrawA.h
	fi

	# Don't install private headers
	rm -f "${D}"/usr/include/GL/GLw*P.h

	fix_opengl_symlinks
	dynamic_libgl_install

	# Install libtool archives
	insinto /usr/$(get_libdir)
	# (#67729) Needs to be lib, not $(get_libdir)
	doins "${FILESDIR}"/lib/libGLU.la
	sed -e "s:\${libdir}:$(get_libdir):g" "${FILESDIR}"/lib/libGL.la \
		> "${D}"/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.la

	# On *BSD libcs dlopen() and similar functions are present directly in
	# libc.so and does not require linking to libdl. portability eclass takes
	# care of finding the needed library (if needed) witht the dlopen_lib
	# function.
	sed -i -e 's:-ldl:'$(dlopen_lib)':g' \
		"${D}"/usr/$(get_libdir)/libGLU.la \
		"${D}"/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.la

	# Create the two-number versioned libs (.so.#.#), since only .so.# and
	# .so.#.#.# were made
	local MAJOR_2="$(printf "%.2i" $(get_version_component_range 1 ${PV}))"
	local MINOR_2="$(printf "%.2i" $(get_version_component_range 2 ${PV}))"
	local MICRO_2="$(printf "%.2i" $(get_version_component_range 3 ${PV}))"
	dosym \
		libGLU.so.1.3.${MAJOR_2}${MINOR_2}${MICRO_2} \
		/usr/$(get_libdir)/libGLU.so.1.3
	dosym libGLw.so.1.0.0 /usr/$(get_libdir)/libGLw.so.1.0

	# libGLU doesn't get the plain .so symlink either
	dosym libGLU.so.1 /usr/$(get_libdir)/libGLU.so

	# Figure out why libGL.so.1.5 is built (directfb), and why it's linked to
	# as the default libGL.so.1
}

pkg_postinst() {
	switch_opengl_implem

	# We need the outer check, because xorg-server may not be installed
	# first, and built_with_use() dies if the package isn't installed.
	if has_version x11-base/xorg-server; then
		if built_with_use x11-base/xorg-server nptl; then
			ewarn "Rebuild x11-base/xorg-server without USE=nptl"
			ewarn "or AIGLX (compiz, etc.) will not work."
			ewarn "This is because of a bug in the Mesa NPTL assembly code"
			ewarn "in all Mesa 7.0.x versions (Mesa 6.x is OK)."
		fi
	fi
}

fix_opengl_symlinks() {
	# Remove invalid symlinks
	local LINK
	for LINK in $(find "${D}"/usr/$(get_libdir) \
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
		for x in "${D}"/usr/$(get_libdir)/libGL.so* \
			"${D}"/usr/$(get_libdir)/libGL.la \
			"${D}"/usr/$(get_libdir)/libGL.a; do
			if [ -f ${x} -o -L ${x} ]; then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} "${D}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/lib
			fi
		done
		# glext.h added for #54984
		for x in "${D}"/usr/include/GL/{gl.h,glx.h,glext.h,glxext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} "${D}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/include
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

# $1 - VIDEO_CARDS flag
# other args - names of DRI drivers to enable
driver_enable() {
	if use $1; then
		shift
		DRI_DRIVERS="${DRI_DRIVERS} $@"
	fi
}
