# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/herqq/herqq-1.0.0.ebuild,v 1.1 2011/04/20 17:43:37 ottxor Exp $

EAPI="3"

inherit base qt4-r2

DESCRIPTION="A software library for building UPnP devices"
HOMEPAGE="http://www.herqq.org"
SRC_URI="mirror://sourceforge/hupnp/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

#no release of QtSolutions using bundled libQtSolutions_SOAP
RDEPEND="x11-libs/qt-core"
DEPEND="${RDEPEND}"

DOCS=( hupnp/ChangeLog )
HTML_DOCS=( hupnp/docs/html/ )

src_configure() {
	eqmake4 herqq.pro PREFIX="${EPREFIX}/usr" || die
}

src_install() {
	qt4-r2_src_install || die
	if use doc; then
		base_src_install_docs || die
	fi
}
