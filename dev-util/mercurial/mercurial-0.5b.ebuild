# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.5b.ebuild,v 1.1 2005/06/24 21:03:54 agriffis Exp $

inherit distutils

DESCRIPTION="fast, lightweight source control management system"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"

src_install() {
	mkdir examples
	mv hgeditor convert-repo examples
	DOCS="PKG-INFO README *.txt examples/*"
	distutils_src_install
	doman doc/hg.1
}
