# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot/yaboot-1.3.14-r2.ebuild,v 1.1 2010/06/24 19:44:02 nixnut Exp $

inherit eutils toolchain-funcs

DESCRIPTION="PPC Bootloader"
SRC_URI="http://yaboot.ozlabs.org/releases/${P}.tar.gz"
HOMEPAGE="http://yaboot.ozlabs.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~ppc -ppc64"
IUSE="ibm"

DEPEND="sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils
				 sys-fs/hfsplusutils
				 sys-fs/mac-fdisk )"

PROVIDE="virtual/bootloader"

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	[ -n "$(tc-getCC)" ] || CC="gcc"
	# dual boot patch
	epatch "${FILESDIR}/yabootconfig-1.3.13.patch"
	epatch "${FILESDIR}/chrpfix.patch"
        if [[ "$(gcc-major-version)" -eq "3" ]]; then
		epatch "${FILESDIR}/yaboot-nopiessp.patch"
        fi
        if [[ "$(gcc-major-version)" -eq "4" ]]; then
		epatch "${FILESDIR}/yaboot-nopiessp-gcc4.patch"
        fi
	epatch "${FILESDIR}/sysfs-ofpath.patch"
	emake PREFIX=/usr MANDIR=share/man CC="$(tc-getCC)" || die
}

src_install() {
	cp etc/yaboot.conf etc/yaboot.conf.bak
	sed -e 's/\/local//' etc/yaboot.conf >| etc/yaboot.conf.edit
	mv -f etc/yaboot.conf.edit etc/yaboot.conf
	make ROOT="${D}" PREFIX=/usr MANDIR=share/man install || die
}
