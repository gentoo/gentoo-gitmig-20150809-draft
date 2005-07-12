# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-qt-tools/aqhbci-qt-tools-1.0.6_beta.ebuild,v 1.1 2005/07/12 21:56:07 hanno Exp $

inherit eutils kde-functions
need-qt 3

DESCRIPTION="KDE wizard for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-1.1.0
	>=x11-libs/qt-3.0.0"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}
