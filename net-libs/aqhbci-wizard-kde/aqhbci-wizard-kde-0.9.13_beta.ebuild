# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-wizard-kde/aqhbci-wizard-kde-0.9.13_beta.ebuild,v 1.5 2005/01/02 19:42:36 kloeri Exp $

inherit eutils kde-functions
need-qt 3

MY_P=${PN/aqhbci-/}-${PV/_/}
DESCRIPTION="KDE wizard for aqhbci"
HOMEPAGE="http://www.aquamaniacs.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-0.9.14_beta
	>=x11-libs/qt-3.0"
S=${WORKDIR}/${MY_P}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
