# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.0.ebuild,v 1.2 2002/08/29 11:44:19 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/libieee1284/stable/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"

DEPEND="app-text/docbook-sgml-utils
	>=app-text/docbook-sgml-dtd-4.1
	app-text/docbook-dsssl-stylesheets
	dev-perl/XML-RegExp"


src_compile() {
	econf || die "./configure failed"

	make || die
}

src_install () {
	einstall || die
}
