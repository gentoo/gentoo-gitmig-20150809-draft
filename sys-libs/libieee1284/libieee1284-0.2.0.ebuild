# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.0.ebuild,v 1.10 2005/07/10 01:00:53 swegener Exp $

inherit libtool

DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

DEPEND="app-text/docbook-sgml-utils
	>=app-text/docbook-sgml-dtd-4.1
	app-text/docbook-dsssl-stylesheets
	dev-perl/XML-RegExp"


src_compile() {
	elibtoolize

	econf || die "./configure failed"

	make || die
}

src_install () {
	einstall || die
}
