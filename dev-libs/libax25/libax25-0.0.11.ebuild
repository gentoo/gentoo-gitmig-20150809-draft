# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libax25/libax25-0.0.11.ebuild,v 1.8 2004/06/24 23:14:05 agriffis Exp $

DESCRIPTION="AX.25 protocol library for various Amateur Radio programs"
HOMEPAGE="http://ax25.sourceforge.net/"
SRC_URI="mirror://sourceforge/ax25/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc/ax25
	newins ${FILESDIR}/axports.gentoo axports

}
