# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-qt-tools/aqhbci-qt-tools-0.9.17_beta.ebuild,v 1.3 2005/04/14 10:39:20 hanno Exp $

inherit eutils kde-functions
need-qt 3

DESCRIPTION="KDE wizard for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-0.9.19_beta
	>=x11-libs/qt-3.0"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
