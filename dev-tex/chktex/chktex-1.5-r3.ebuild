# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/chktex/chktex-1.5-r3.ebuild,v 1.1 2004/09/21 12:10:03 usata Exp $

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
	# datadir is where chktexrc is located
	econf --datadir=/etc `use_enable debug debug-info` || die
	emake || die
}

src_install() {
	einstall datadir=${D}/etc || die
	dodoc COPYING SCOPTIONS
}
