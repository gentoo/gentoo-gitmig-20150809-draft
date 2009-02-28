# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakefood/snakefood-1.3.1.ebuild,v 1.1 2009/02/28 20:26:23 patrick Exp $

inherit distutils

DESCRIPTION="Generate dependency graphs from Python code"
HOMEPAGE="http://furius.ca/snakefood/"
SRC_URI="http://furius.ca/downloads/${PN}/releases/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.5"
RDEPEND="$DEPEND"
DOCS="CHANGES"

src_install() {
	distutils_src_install
}
