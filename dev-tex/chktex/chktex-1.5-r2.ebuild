# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/chktex/chktex-1.5-r2.ebuild,v 1.4 2004/02/09 08:26:23 absinthe Exp $

DESCRIPTION="Checks latex source for common mistakes"
HOMEPAGE="http://www.nongnu.org/chktex/"
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE="debug"

DEPEND="virtual/tetex
	dev-lang/perl
	sys-apps/groff
	dev-tex/latex2html"

src_compile() {
	econf `use_enable debug debug-info` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING SCOPTIONS
}
