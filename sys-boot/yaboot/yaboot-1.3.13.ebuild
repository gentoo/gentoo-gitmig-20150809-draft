# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot/yaboot-1.3.13.ebuild,v 1.9 2006/04/14 17:57:53 wormo Exp $

inherit eutils toolchain-funcs

DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/bootloaders/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ppc -ppc64"
IUSE="ibm"

DEPEND="sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils )
		!ibm? ( sys-fs/hfsplusutils )"

PROVIDE="virtual/bootloader"

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	[ -n "$(tc-getCC)" ] || CC="gcc"
	# dual boot patch
	epatch ${FILESDIR}/yabootconfig-${PV}.patch
	epatch ${FILESDIR}/chrpfix.patch
	epatch ${FILESDIR}/yaboot-3.4.patch
	epatch ${FILESDIR}/yaboot-${PV}-ofpath.patch
	epatch ${FILESDIR}/yaboot-nopiessp.patch
	emake PREFIX=/usr MANDIR=share/man CC="$(tc-getCC)" || die
}

src_install() {
	cp etc/yaboot.conf etc/yaboot.conf.bak
	sed -e 's/\/local//' etc/yaboot.conf >| etc/yaboot.conf.edit
	mv -f etc/yaboot.conf.edit etc/yaboot.conf
	make ROOT=${D} PREFIX=/usr MANDIR=share/man install || die
}

pkg_postinst() {
	ewarn "Please note if you are running a 2.6 kernel the version"
	ewarn "of ofpath included in this revision of yaboot requires"
	ewarn "that you run a kernel >= 2.6.3, prior versions are unsupported."
}
