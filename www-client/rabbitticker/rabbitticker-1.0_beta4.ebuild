# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rabbitticker/rabbitticker-1.0_beta4.ebuild,v 1.4 2004/10/17 10:01:47 dholm Exp $

DESCRIPTION="Skinnable RSS client for QT"
HOMEPAGE="http://www.work-at.co.jp/rabbit/"
SRC_URI="http://www.work-at.co.jp/rabbit/${PN}-${PV/_beta/b}.tar.gz"

LICENSE="QPL"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="x11-libs/qt"
RDEPEND="x11-libs/qt"

S=${WORKDIR}/${PN}-${PV/_beta/b}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
