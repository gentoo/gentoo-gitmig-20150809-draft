# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgasync/pgasync-2.01.ebuild,v 1.1 2005/03/15 18:12:37 nakano Exp $

inherit distutils

DESCRIPTION="An asynchronous api to postgres for twisted."
HOMEPAGE="http://www.jamwt.com/pgasync/"
SRC_URI="http://www.jamwt.com/pgasync/files/${P}.tar.gz"
LICENSE="pgasync"
SLOT="0"

KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-python/twisted-1.3
	>=dev-lang/python-2.3"

DOCS="CHANGELOG LICENSE PKG-INFO README TODO"

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
