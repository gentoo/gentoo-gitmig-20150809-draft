# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.9.17-r1.ebuild,v 1.1 2002/12/29 22:22:25 azarah Exp $

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

pkg_setup() {

	check_KV
}

src_unpack() {

	unpack ${A}
	
	cd ${S};
	epatch ${FILESDIR}/${P}-gentoo.patch

	# Get it to work with kernel 2.5
	epatch ${FILESDIR}/${P}-kernel25.patch
}

check_kernel() {
	
	local KV_MAJOR="`uname -r | cut -d. -f1`"
	local KV_MINOR="`uname -r | cut -d. -f2`"
	export INCLUDEDIR="/usr/src/linux/include"

	# Are we running kernel 2.5 ?
	if [ "${KV_MAJOR}${KV_MINOR}" -gt "24" ]
	then
		# Setup the proper mach include directory ...
		if [ -d ${INCLUDEDIR}/asm/mach-default ]
		then
			export INCLUDEDIR="${INCLUDEDIR} -I${INCLUDEDIR}/asm/mach-default"
			
		elif [ -d ${INCLUDEDIR}/asm/mach-generic ]
		then
			export INCLUDEDIR="${INCLUDEDIR} -I${INCLUDEDIR}/asm/mach-generic"
		else
			die "Cannot find kernel includes!"
		fi
	fi
}

src_compile() {

	check_kernel

	make OPTIMIZE="${CFLAGS}" static shared textutils lrmi utils || die
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} || die
	rm -f src/svgalib_helper.h
	make OPTIMIZE="${CFLAGS}" -C src libvga.so.${PV} || die
	cp -a src/libvga.so.${PV} sharedlib/
	make OPTIMIZE="${CFLAFS}" LDFLAGS='-L ../sharedlib' \
		-C threeDKit lib3dkit.a || die
	
	# For kernel 2.5, we need to set $MODVER, else it fails.  The
	# other alternative is to patch the Makefile, but too much hassle ...
	if [ "${KV_MAJOR}${KV_MINOR}" -gt "24" ]
	then
		make INCLUDEDIR="${INCLUDEDIR}" MODVER="foo" \
			-C kernel/svgalib_helper
	else
		make INCLUDEDIR="${INCLUDEDIR}" -C kernel/svgalib_helper
	fi
	
	make OPTIMIZE="${CFLAGS}" LDFLAGS='-L ../sharedlib' demoprogs || die
	cp Makefile Makefile.orig
	sed -e 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
	 	Makefile.orig > Makefile
}

src_install() {

	check_kernel

	dodir /etc/svgalib /usr/{include,lib,bin,share/man}
	
	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" \
		INCLUDEDIR="${INCLUDEDIR}" install || die
	
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

