# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-0.9.10.ebuild,v 1.6 2007/07/14 16:06:23 cedk Exp $

inherit distutils

DESCRIPTION="Python bindings for Graphviz"
HOMEPAGE="http://dkbza.org/pydot.html"
SRC_URI="http://dkbza.org/data/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-python/pyparsing
	media-gfx/graphviz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-quote.patch
}
