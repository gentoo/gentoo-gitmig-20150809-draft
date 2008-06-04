# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.2_p20080604.ebuild,v 1.1 2008/06/04 13:36:01 yngwin Exp $

EAPI=1
inherit eutils qt4

DESCRIPTION="A cross-platform Qt4 WebKit browser"
HOMEPAGE="http://arora.googlecode.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/qt-webkit-4.4.0:4"
DEPEND="${RDEPEND}"

src_compile() {
	eqmake4 || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	dobin arora
	newicon src/data/browser.svg arora.svg
	make_desktop_entry arora Arora arora.svg
}
