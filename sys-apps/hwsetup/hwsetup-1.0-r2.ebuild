# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwsetup/hwsetup-1.0-r2.ebuild,v 1.5 2005/04/06 18:52:38 corsair Exp $

inherit eutils

MY_PV=${PV}-14
DESCRIPTION="Hardware setup program"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc -sparc -mips alpha amd64 ppc64"
IUSE=""

DEPEND=">=sys-apps/kudzu-knoppix-1.0"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake  || die
}

src_install() {
	einstall DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"
}
