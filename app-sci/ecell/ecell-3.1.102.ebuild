# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ecell/ecell-3.1.102.ebuild,v 1.1 2004/07/26 12:06:15 chrb Exp $

inherit eutils

DESCRIPTION="Software suite for modelling biological cells"
HOMEPAGE="http://ecell.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecell/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND="dev-libs/boost
	dev-lang/python
	dev-python/numeric
	dev-libs/gsl
	dev-python/empy
	gtk? ( gnome-base/libglade )
	doc? ( media-gfx/graphviz app-doc/doxygen )"

src_compile() {
	econf `use_enable gtk`
	emake
	if use doc; then
		emake doc
	fi
}

src_install() {
	einstall || die
	if use doc; then 
		dohtml doc/refman/html
	fi
}
