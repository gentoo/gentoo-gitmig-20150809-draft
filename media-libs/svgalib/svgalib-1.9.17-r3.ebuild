# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.9.17-r3.ebuild,v 1.9 2004/01/18 04:09:09 vapier Exp $

inherit eutils

DESCRIPTION="A library for running svga graphics on the console"
HOMEPAGE="http://www.svgalib.org/"
SRC_URI="http://www.arava.co.il/matan/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86"
IUSE="build"

DEPEND="virtual/glibc"

pkg_setup() {
	use build || check_KV
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	# Get it to work with kernel 2.6
	epatch ${FILESDIR}/${P}-linux2.6.patch

	# Get modversions.h include right if we have CONFIG_MODVERSIONS set.
	epatch ${FILESDIR}/${P}-modversions_h.patch

	# Disable kernel module support while building stages #38403
	if [ `use build` ] ; then
		sed -i 's:installmodule ::' Makefile
	fi
}

src_compile() {
	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml or #gentoo-hardened/irc.freenode
	has_version "sys-devel/hardened-gcc" && CC="${CC} -yet_exec"

	make OPTIMIZE="${CFLAGS}" static shared textutils lrmi utils \
		|| die "Failed to build libraries and utils!"
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die "Failed to build gl!"
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} \
		|| die "Failed to build libvgagl.so.${PV}!"
	rm -f src/svgalib_helper.h
	make OPTIMIZE="${CFLAGS}" -C src libvga.so.${PV} \
		|| die "Failed to build libvga.so.${PV}!"
	cp -a src/libvga.so.${PV} sharedlib/
	make OPTIMIZE="${CFLAFS}" LDFLAGS='-L ../sharedlib' \
		-C threeDKit lib3dkit.a || die "Failed to build threeDKit!"

	if [ ! `use build` ] ; then
		make INCLUDEDIR="/usr/src/linux/include" -C kernel/svgalib_helper \
			clean all || die "Failed to build kernel module!"
	fi

	make OPTIMIZE="${CFLAGS}" LDFLAGS='-L ../sharedlib' demoprogs \
		|| die "Failed to build demoprogs!"

	cp Makefile Makefile.orig
	sed -e 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
	 	Makefile.orig > Makefile
}

src_install() {
	local x=

	dodir /etc/svgalib /usr/{include,lib,bin,share/man}

	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" \
		INCLUDEDIR="/usr/src/linux/include" install \
		|| die "Failed to install svgalib!"

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

	dodir /etc/modules.d
	echo "probeall  /dev/svga  svgalib_helper" > ${D}/etc/modules.d/svgalib

	exeinto /usr/lib/svgalib/demos
	for x in ${S}/demos/*
	do
		[ -x "${x}" ] && doexe ${x}
	done

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
