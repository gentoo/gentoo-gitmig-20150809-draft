# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/colo/colo-1.16.ebuild,v 1.1 2005/03/21 03:00:33 kumba Exp $

inherit eutils

DESCRIPTION="CObalt LOader - Modern bootloader for Cobalt MIPS machines"
HOMEPAGE="http://www.colonel-panic.org/cobalt-mips/"
SRC_URI="http://www.colonel-panic.org/cobalt-mips/colo/colo-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~mips"
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

	# cp the bootscripts to WORKDIR
	cp ${FILESDIR}/menu-linux.colo ${WORKDIR}

	# sed the primary boot script and stick the current colo version in there
	sed "s:@COLOVER@:${PV}:g" ${FILESDIR}/default.colo > ${WORKDIR}/default.colo
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

	# lcdtools
	echo -e ""
	einfo ">>> Building lcdtools ..."
	cd ${S}/tools/lcdtools
	make clean || die
	make || die

	# elf2rfx
	echo -e ""
	einfo ">>> Building elf2rfx ..."
	cd ${S}/tools/elf2rfx
	make clean || die
	make || die
}

src_install() {
	# bins
	cd ${S}
	dodir /usr/lib/colo
	cp binaries/colo-chain.elf ${D}/usr/lib/colo
	cp binaries/colo-rom-image.bin ${D}/usr/lib/colo

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

	# lcdtools
	for tool in paneld putlcd e2fsck-lcd; do
		dosbin tools/lcdtools/${tool}/${tool}
		doman tools/lcdtools/${tool}/${tool}.8
	done
	dolib.a tools/lcdtools/liblcd/liblcd.a

	# elf2rfx
	dosbin tools/elf2rfx/elf2rfx

	# bootscripts
	dodir /usr/lib/colo/scripts
	cp ${WORKDIR}/default.colo ${WORKDIR}/menu-linux.colo ${D}/usr/lib/colo/scripts
}

pkg_postinst() {
	echo -e ""
	einfo "Install locations:"
	einfo "   Binaries:\t/usr/lib/${PN}"
	einfo "   Docs:\t/usr/share/doc/${PF}"
	einfo "   Tools:\t/usr/sbin/{flash-tool,colo-perm,md5rom,"
	einfo "         \tputlcd,paneld,e2fsck-lcd,elf2rfx}"
	einfo "   Scripts:\t/usr/lib/${PN}/scripts"
	echo -e ""
	einfo "Please read the docs to fully understand the behavior of this bootloader, and"
	einfo "edit the boot scripts to suit your needs."
	echo -e ""
	ewarn "Please note that the 'menu' command, introduced in colo-1.12 has been replaced"
	ewarn "by the 'select' command.  Have a look at the menu.colo example in the example"
	ewarn "scripts directory for hints on updating your boot scripts if necessary."
	echo -e ""
	ewarn "Users installing ${PN} for the first time need to be aware that newer"
	ewarn "versions of ${PN} disable the serial port by default.  If the serial port"
	ewarn "is needed, select it from the boot menu.  Users using the example boot"
	ewarn "scripts provided will have the serial port automatically enabled."
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
