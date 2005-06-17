# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-latex/gaim-latex-0.3.ebuild,v 1.2 2005/06/17 09:53:24 dholm Exp $

DESCRIPTION="Gaim plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/gaim-latex"
SRC_URI="mirror://sourceforge/gaim-latex/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="net-im/gaim"
RDEPEND="virtual/tetex
		media-gfx/imagemagick"

src_compile()
{
	emake || die "emake failed"
}

src_install()
{
	make install PREFIX=${D}/usr || die "make install failed"
	dodoc README CHANGELOG COPYING TODO
}
