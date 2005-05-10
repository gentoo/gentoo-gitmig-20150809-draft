# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-latex/gaim-latex-0.2.ebuild,v 1.1 2005/05/10 14:59:23 rizzo Exp $

DESCRIPTION="Gaim plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/gaim-latex"
SRC_URI="mirror://sourceforge/gaim-latex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-im/gaim"
RDEPEND="app-text/tetex
		dev-tex/tex2im"

src_compile()
{
	emake || die "emake failed"
}

src_install()
{
	make install PREFIX=${D}/usr || die "make install failed"
	dodoc README CHANGELOG COPYING TODO
}
