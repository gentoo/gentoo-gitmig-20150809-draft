# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/arcload/arcload-0.43-r1.ebuild,v 1.6 2010/12/14 01:38:32 mattst88 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="ARCLoad - SGI Multi-bootloader.  Able to bootload many different SGI Systems."
HOMEPAGE="http://www.linux-mips.org/wiki/index.php/ARCLoad"
SRC_URI="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~mips"
IUSE=""
DEPEND="sys-boot/dvhtool"
RDEPEND=""
RESTRICT="strip"
PROVIDE="virtual/bootloader"

pkg_setup() {
	# See if we're on a cobalt system
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		eerror "This package is only intended for SGI systems.  It will not work on any"
		eerror "other types of MIPS-based systems or any other architectures"
		echo -e ""
		die
	fi
}

src_unpack() {
	unpack ${A}

	# Adds in detection support for the R14000, and
	# tweaks detectbaud() in loader/detect.c to return
	# a default of 9600bps when the function fails
	epatch "${FILESDIR}"/${P}-tweaks1.patch
}

src_compile() {
	echo -e ""
	einfo ">>> Building 32-bit version (sashARCS) for IP22/IP32 ..."
	cd "${S}"
	make MODE=M32 clean || die
	make CC=$(tc-getCC) LD=$(tc-getLD) MODE=M32 || die
	cp "${S}"/arcload.ecoff "${WORKDIR}"/sashARCS

	echo -e ""
	einfo ">>> Building 64-bit version (sash64) for IP27/IP28/IP30 ..."
	make MODE=M64 clean || die
	make CC=$(tc-getCC) LD=$(tc-getLD) MODE=M64 || die
	cp $"{S}"/arcload "${WORKDIR}"/sash64
}

src_install() {
	dodir /usr/lib/arcload
	cp "${WORKDIR}"/sashARCS "${D}"/usr/lib/arcload
	cp "${WORKDIR}"/sash64 "${D}"/usr/lib/arcload
	cp "${S}"/arc.cf-bootcd "${D}"/usr/lib/arcload/arc-bootcd.cf
	cp "${S}"/arc.cf-octane "${D}"/usr/lib/arcload/arc-octane.cf
}

pkg_postinst() {
	echo -e ""
	einfo "ARCLoad binaries copied to: /usr/lib/arcload"
	echo -e ""
	einfo "Use of ARCLoad is relatively easy:"
	einfo "\t1) Determine which version you need"
	einfo "\t\tA) sashARCS for IP22/IP32"
	einfo "\t\tB) sash64 for IP27/IP28/IP30"
	einfo "\t2) Copy that to the volume header using 'dvhtool'"
	einfo "\t3) Edit /usr/lib/arcload/arc-*.cf to fit your specific system"
	einfo "\t   (See ${HOMEPAGE} for"
	einfo "\t    an explanation of the format of the config file)"
	einfo "\t4) Copy the config file to the volume header with 'dvhtool' (make sure it is copied as 'arc.cf')"
	einfo "\t5) Copy any kernels to the volume header that you want to be bootable"
	einfo "\t6) Reboot, and enjoy!"
	echo -e ""
}
