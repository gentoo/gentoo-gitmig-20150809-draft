# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot/yaboot-1.3.11-r1.ebuild,v 1.9 2006/04/14 17:57:53 wormo Exp $

inherit eutils toolchain-funcs

DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/bootloaders/archived/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ppc ppc64"
IUSE=""

DEPEND="sys-apps/powerpc-utils
	sys-fs/hfsutils
	sys-fs/hfsplusutils"

PROVIDE="virtual/bootloader"

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	[ -n "$(tc-getCC)" ] || CC="gcc"
	# dual boot patch
	epatch ${FILESDIR}/yabootconfig-${PV}.patch
	epatch ${FILESDIR}/chrpfix.patch
	#took from http://penguinppc.org/~eb/files/ofpath
	epatch ${FILESDIR}/${P}-ofpath-fix.patch
	emake PREFIX=/usr MANDIR=share/man CC="$(tc-getCC)" || die

}

src_install() {
	cp etc/yaboot.conf etc/yaboot.conf.bak
	sed -e 's/\/local//' etc/yaboot.conf >| etc/yaboot.conf.edit
	mv -f etc/yaboot.conf.edit etc/yaboot.conf
	make ROOT=${D} PREFIX=/usr MANDIR=share/man install || die
}
