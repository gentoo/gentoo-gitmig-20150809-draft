# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/optcomplete/optcomplete-1.2.ebuild,v 1.1 2008/06/25 11:40:55 hawking Exp $

inherit distutils

DESCRIPTION="Shell completion self-generator for python"
HOMEPAGE="http://furius.ca/optcomplete/"
SRC_URI="http://furius.ca/downloads/${PN}/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=""
RDEPEND=""

DOCS="CHANGES"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins bin/* || die "doins failed"
	fi
}
