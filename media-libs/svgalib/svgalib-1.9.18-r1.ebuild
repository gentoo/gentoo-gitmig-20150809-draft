# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.9.18-r1.ebuild,v 1.14 2004/07/19 17:10:10 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="A library for running svga graphics on the console"
HOMEPAGE="http://www.svgalib.org/"
SRC_URI="http://www.arava.co.il/matan/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86"
IUSE="build"

DEPEND="virtual/libc"

kernel_supports_modules() {
	grep '^CONFIG_MODULES=y$' /usr/src/linux/.config >& /dev/null
}

pkg_setup() {
	! use build && kernel_supports_modules && check_KV
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	# Fix a small gcc33 issue
	epatch ${FILESDIR}/${P}-gcc33.patch

	# Fix a small gcc34 issue #48930
	epatch ${FILESDIR}/${P}-gcc34.patch

	# Get it to work with kernel 2.6
	epatch ${FILESDIR}/${P}-linux2.6-v2.patch

	# Fix include bug #54198
	epatch ${FILESDIR}/${P}-utils-include.patch

	# Have lrmi compile with our $CFLAGS
	epatch ${FILESDIR}/${P}-lrmi-gentoo-cflags.patch

	# Disable kernel module support while building stages #38403
	#use build && 
	sed -i 's:installmodule ::' Makefile
	# for now we dont build the module at all #42522
}

src_compile() {
	filter-flags "-fPIC"

	# First build static
	make OPTIMIZE="${CFLAGS}" static \
		|| die "Failed to build static libraries!"
	# Have to remove for shared to build ...
	rm -f src/svgalib_helper.h
	# Then build shared ...
	make OPTIMIZE="${CFLAGS}" shared \
		|| die "Failed to build shared libraries!"
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
	cp -a src/libvga.so.${PV} sharedlib/
	# Build threeDKit ...
	make OPTIMIZE="${CFLAFS}" LDFLAGS='-L../sharedlib' \
		-C threeDKit lib3dkit.a || die "Failed to build threeDKit!"
	# Build demo's ...
	make OPTIMIZE="${CFLAGS} -I../gl" LDFLAGS='-L../sharedlib' \
		demoprogs || die "Failed to build demoprogs!"

	if ! use build && kernel_supports_modules
	then
		cd ${S}/kernel/svgalib_helper
		if [[ `KV_to_int ${KV}` -lt `KV_to_int 2.6.6` ]] ; then
			env -u ARCH \
				make -f Makefile.alt INCLUDEDIR="/usr/src/linux/include" \
					clean modules || die "Failed to alt build kernel module!"
		else
			env -u ARCH make || die "Failed to build kernel module!"
		fi
		cd ${S}
	fi

	cp Makefile Makefile.orig
	sed -e 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
	 	Makefile.orig > Makefile
}

src_install() {
	local x=

	dodir /etc/svgalib /usr/{include,lib,bin,share/man}

	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" \
		install || die "Failed to install svgalib!"
	if ! use build && kernel_supports_modules
	then
		cd ${S}/kernel/svgalib_helper
		if [[ `KV_to_int ${KV}` -lt `KV_to_int 2.6.6` ]] ; then
			env -u ARCH \
				make -f Makefile.alt TOPDIR=${D} \
					INCLUDEDIR="/usr/src/linux/include" \
					modules_install || die "Failed to install svgalib module!"
		else
			insinto /lib/modules/${KV}/kernel/misc
			doins svgalib_helper.ko
		fi
		cd ${S}
	fi

	insinto /usr/include
	doins gl/vgagl.h
	dolib.a staticlib/libvga.a
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
	exeinto /usr/lib/svgalib/threeDKit
	local THREED_PROGS="plane wrapdemo"
	doexe ${THREED_PROGS}

	cd ${S}
	dodoc 0-README LICENSE
	cd ${S}/doc
	dodoc CHANGES DESIGN TODO
	docinto txt
	dodoc  Driver-programming-HOWTO README.* add_driver svgalib.lsm

	mv ${D}/usr/man/* ${D}/usr/share/man
}

pkg_postinst() {
	[ "${ROOT}" = "/" ] && /sbin/modules-update &> /dev/null
	einfo "When upgrading your kernel you'll need to rebuild the kernel module."
}
