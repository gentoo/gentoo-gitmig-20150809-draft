# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/colo/colo-1.11.ebuild,v 1.2 2004/09/03 06:19:03 kumba Exp $

inherit eutils

DESCRIPTION="CObalt LOader - Modern bootloader for Cobalt MIPS machines"
HOMEPAGE="http://www.colonel-panic.org/cobalt-mips/"
SRC_URI="http://www.colonel-panic.org/cobalt-mips/colo/colo-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""
DEPEND=""
RESTRICT="nostrip"


pkg_setup() {
	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if [ "${PROFILE_ARCH}" != "cobalt" ]; then
		echo -e ""
		eerror "This package is only intended for the Cobalt Microserver MIPS-based"
		eerror "systems.  It will not function on any other MIPS-based system or any"
		eerror "other architecture"
		echo -e ""
		die
	fi
}

src_unpack() {
	unpack ${A}

	# patch Docs
	cd ${S}
	epatch ${FILESDIR}/colo-linker-overlap-fix.patch
}

src_compile() {
	# boot-loader
	echo -e ""
	einfo ">>> Building the CoLo Bootloader ..."
	cd ${S}
	make clean || die	# emake breaks the build
	make || die

	# flash-tool
	echo -e ""
	einfo ">>> Building flash-tool ..."
	cd ${S}/tools/flash-tool
	make clean || die
	make || die

	# colo-perm
	echo -e ""
	einfo ">>> Building colo-perm ..."
	cd ${S}/tools/colo-perm
	make clean || die
	make || die

	# md5rom
	echo -e ""
	einfo ">>> Building md5rom ..."
	cd ${S}/tools/md5rom
	make clean || die
	make || die
}

src_install() {
	# bins
	cd ${S}
	dodir /usr/lib/colo
	cp binaries/colo-chain.elf ${D}/usr/lib/colo
	cp binaries/colo-rom-image.bin ${D}/usr/lib/colo
	cp ${FILESDIR}/default.boot.example ${D}/usr/lib/colo/default.colo.example

	# docs
	dodoc CHANGES COPYING INSTALL README README.{restore,shell} TODO

	# flash-tool
	dosbin tools/flash-tool/flash-tool
	doman tools/flash-tool/flash-tool.8

	# colo-perm
	dosbin tools/colo-perm/colo-perm
	doman tools/colo-perm/colo-perm.8

	# md5rom
	dosbin tools/md5rom/md5rom
	doman tools/md5rom/md5rom.8
}

pkg_postinst() {
	echo -e ""
	einfo "Install locations:"
	einfo "   Binaries:\t/usr/lib/${PN}"
	einfo "   Docs:\t/usr/share/doc/${PF}"
	einfo "   Tools:\t/usr/bin/{flash-tool,colo-perm,md5rom}"
	einfo "   Scripts:\t/usr/lib/${PN}/scripts"
	echo -e ""
	einfo "Please read the docs to fully understand the behavior of this bootloader, and"
	einfo "edit the boot scripts to suit your needs."
	echo -e ""
	echo -e ""
	ewarn "Note: It is HIGHLY recommended that you use the chain"
	ewarn "bootloader (colo-chain.elf) first before attempting to"
	ewarn "write the bootloader to the flash chip to verify that"
	ewarn "it will work for you.  It is also recommended that"
	ewarn "you read the documentation in /usr/share/doc/${PF}"
	ewarn "as it explains how to properly use this package."
	echo -e ""
	eerror "Warning: Make sure that IF you plan on flashing the"
	eerror "bootloader into the flash chip that you are using a"
	eerror "modern 2.4 Linux kernel (i.e., >2.4.18), otherwise"
	eerror "you run a risk of destroying the contents of the"
	eerror "flash chip and rendering the machine unusable."
	echo -e ""
	echo -e ""
}
