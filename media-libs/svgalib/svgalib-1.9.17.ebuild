# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.9.17.ebuild,v 1.2 2003/02/13 12:56:13 vapier Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="A library for running svga graphics on the console"
SRC_URI="http://www.arava.co.il/matan/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.svgalib.org/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 -ppc -sparc "

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	
	cd ${S};
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {

	make OPTIMIZE="${CFLAGS}" static shared textutils lrmi utils || die
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} || die
	rm -f src/svgalib_helper.h
	make OPTIMIZE="${CFLAGS}" -C src libvga.so.${PV} || die
	cp -a src/libvga.so.${PV} sharedlib/
	make OPTIMIZE="${CFLAFS}" LDFLAGS='-L ../sharedlib' \
		-C threeDKit lib3dkit.a || die
	make INCLUDEDIR="/usr/src/linux/include" -C kernel/svgalib_helper
	make OPTIMIZE="${CFLAGS}" LDFLAGS='-L ../sharedlib' demoprogs || die
	cp Makefile Makefile.orig
	sed -e 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
	 	Makefile.orig > Makefile
}

src_install() {

	dodir /etc/svgalib /usr/{include,lib,bin,share/man}
	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" install || die
	insinto /usr/include
	doins gl/vgagl.h
	dolib.a gl/libvgagl.a
	dolib.a threeDKit/lib3dkit.a
	dolib.so gl/libvgagl.so.${PV}
	dosym libvgagl.so.${PV} /usr/lib/libvgagl.so
	preplib

	insinto /usr/include
	doins src/vga.h gl/vgagl.h src/mouse/vgamouse.h src/joystick/vgajoystick.h
	doins src/keyboard/vgakeyboard.h

	echo "probeall  /dev/svga  svgalib_helper" > ${D}/etc/modules.d/svgalib

	cd ${S}/demos
	exeinto /usr/lib/svgalib/demos
	local DEMO_PROGS="fun testgl speedtest mousetest vgatest scrolltest \
		testlinear \
		keytest testaccel accel forktest eventtest spin bg_test printftest \
		joytest mjoytest bankspeed lineart linearspeed addmodetest \
		svidtune linearfork vgatweak"
	doexe ${DEMO_PROGS}

	cd ${S}/threeDKit
	exeinto /usr/lib/svgalib/theeDKit
	local THREED_PROGS="plane wrapdemo"
	doexe ${THREED_PROGS}

	cd ${S}/doc
	dodoc CHANGES DESIGN TODO
	docinto txt
	dodoc  Driver-programming-HOWTO README.* add_driver svgalib.lsm
}

pkg_postinst() {

	 [ "${ROOT}" = "/" ] && /sbin/modules-update &> /dev/null
}

