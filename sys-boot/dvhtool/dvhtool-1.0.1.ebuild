# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/dvhtool/dvhtool-1.0.1.ebuild,v 1.6 2004/07/15 02:49:36 agriffis Exp $

DESCRIPTION="Dvhtool is the tool responsible for writing MIPS kernel(s) into the SGI volume header"
HOMEPAGE="http://packages.debian.org/unstable/utils/dvhtool.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/dvhtool/dvhtool_1.0.1.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 mips"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}
	cd ${S}.orig
	patch -p1 < ${FILESDIR}/dvhtool-1.0.1-2.diff || die
}
src_compile() {
	cd ${S}.orig
	econf || die "econf failed"
	emake || die "Failed to compile"
}

src_install() {
	cd ${S}.orig
	einstall

}
