# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.9.25.ebuild,v 1.4 2007/02/12 05:09:35 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs linux-mod

DESCRIPTION="A library for running svga graphics on the console"
HOMEPAGE="http://www.svgalib.org/"
SRC_URI="http://www.arava.co.il/matan/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86"
IUSE="build no-helper"

DEPEND=""

MODULE_NAMES="svgalib_helper(misc:${S}/kernel/svgalib_helper)"
BUILD_TARGETS="default"
MODULESD_SVGALIB_HELPER_ADDITIONS="probeall  /dev/svga  svgalib_helper"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_OUT_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Misc makefile clean ups
	epatch "${FILESDIR}"/${PN}-1.9.25-gentoo.patch

	# Get it to work with kernel 2.6
	epatch "${FILESDIR}"/${PN}-1.9.25-linux2.6.patch

	# -fPIC does work for lrmi, see bug #51698
	epatch "${FILESDIR}"/${PN}-1.9.19-pic.patch

	# Don't strip stuff, let portage do it
	epatch "${FILESDIR}"/${PN}-1.9.25-build.patch
}

src_compile() {
	use no-helper && export NO_HELPER=y

	export CC=$(tc-getCC)

	# First build static
	make OPTIMIZE="${CFLAGS}" static || die "Failed to build static libraries!"
	# Have to remove for shared to build ...
	rm -f src/svgalib_helper.h
	# Then build shared ...
	make OPTIMIZE="${CFLAGS}" shared || die "Failed to build shared libraries!"
	# Missing in some cases ...
	ln -s libvga.so.${PV} sharedlib/libvga.so
	# Build lrmi and tools ...
	make OPTIMIZE="${CFLAGS}" LDFLAGS="-L../sharedlib" \
		textutils lrmi utils \
		|| die "Failed to build libraries and utils!"
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die "Failed to build gl!"
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} \
		|| die "Failed to build libvgagl.so.${PV}!"
	# Missing in some cases ...
	ln -s libvgagl.so.${PV} sharedlib/libvgagl.so
	rm -f src/svgalib_helper.h
	make OPTIMIZE="${CFLAGS}" -C src libvga.so.${PV} \
		|| die "Failed to build libvga.so.${PV}!"
	cp -pPR src/libvga.so.${PV} sharedlib/
	# Build threeDKit ...
	make OPTIMIZE="${CFLAGS}" LDFLAGS='-L../sharedlib' \
		-C threeDKit lib3dkit.a || die "Failed to build threeDKit!"
	# Build demo's ...
	make OPTIMIZE="${CFLAGS} -I../gl" LDFLAGS='-L../sharedlib' \
		demoprogs || die "Failed to build demoprogs!"

	! use build && ! use no-helper && linux-mod_src_compile
}

src_install() {
	local x=

	dodir /etc/svgalib /usr/{include,lib,bin,share/man}

	make \
		TOPDIR="${D}" OPTIMIZE="${CFLAGS}" INSTALLMODULE="" \
		install || die "Failed to install svgalib!"
	! use build && ! use no-helper && linux-mod_src_install

	insinto /usr/include
	doins gl/vgagl.h
	dolib.a staticlib/libvga.a || die "dolib.a libvga"
	dolib.a gl/libvgagl.a || die "dolib.a libvgagl"
	dolib.a threeDKit/lib3dkit.a
	dolib.so gl/libvgagl.so.${PV} || die "dolib.so libvgagl.so"
	local abiver=$(sed -n '/^MAJOR_VER.*=/{s:.*=[ ]*::;p}' Makefile.cfg)
	for x in lib3dkit libvga libvgagl ; do
		dosym ${x}.so.${PV} /usr/lib/${x}.so
		dosym ${x}.so.${PV} /usr/lib/${x}.so.${abiver}
	done

	insinto /usr/include
	doins src/vga.h gl/vgagl.h src/mouse/vgamouse.h src/joystick/vgajoystick.h
	doins src/keyboard/vgakeyboard.h

	if best_version '>=sys-fs/udev-045' ; then
		insinto /etc/udev/rules.d
		newins "${FILESDIR}"/svgalib.udev.rules.d 30-svgalib.rules
	elif best_version sys-fs/udev ; then
		insinto /etc/udev/permissions.d
		newins "${FILESDIR}"/svgalib.udev.perms.d 30-svgalib.permissions
	elif best_version sys-fs/devfsd ; then
		insinto /etc/devfs.d
		newins "${FILESDIR}"/svgalib.devfs svgalib
	fi

	exeinto /usr/lib/svgalib/demos
	for x in "${S}"/demos/* ; do
		[[ -x ${x} ]] && doexe ${x}
	done

	cd "${S}"/threeDKit
	exeinto /usr/lib/svgalib/threeDKit
	local THREED_PROGS="plane wrapdemo"
	doexe ${THREED_PROGS}

	cd "${S}"
	dodoc 0-README
	cd "${S}"/doc
	dodoc CHANGES DESIGN TODO
	docinto txt
	dodoc Driver-programming-HOWTO README.* add_driver svgalib.lsm
}

pkg_postinst() {
	! use build && ! use no-helper && linux-mod_pkg_postinst
}
