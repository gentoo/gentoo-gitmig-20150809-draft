# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kakasi/kakasi-2.3.4.ebuild,v 1.1 2003/06/20 16:44:40 yakina Exp $

IUSE=""

DESCRIPTION="KAnji KAna Simple Inverter, language filter for Japanese"
HOMEPAGE="http://kakasi.namazu.org/"
SRC_URI="http://kakasi.namazu.org/stable/${P}.tar.gz
	ftp://kakasi.namazu.org/pub/kakasi/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
#RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
	emake check || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL* NEWS ONEWS README* THANKS \
		TODO doc/JISYO doc/ChangeLog.lib

	# install japanese man
	insopts -m0644
	insinto /usr/share/man/ja/man1 ; doins doc/kakasi.1
}
