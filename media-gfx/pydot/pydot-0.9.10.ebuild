# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-0.9.10.ebuild,v 1.1 2006/12/06 21:39:48 cedk Exp $

inherit distutils

DESCRIPTION="Python bindings for Graphviz"
HOMEPAGE="http://dkbza.org/"
SRC_URI="http://dkbza.org/data/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-python/pyparsing
	media-gfx/graphviz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-quote.patch
}
