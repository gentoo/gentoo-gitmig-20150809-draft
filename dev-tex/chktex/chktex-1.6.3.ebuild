# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/chktex/chktex-1.6.3.ebuild,v 1.1 2006/04/11 15:29:16 ehmsen Exp $

DESCRIPTION="Checks latex source for common mistakes"
HOMEPAGE="http://www.nongnu.org/chktex/"
SRC_URI="http://baruch.ev-en.org/proj/chktex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
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
	make install DESTDIR=${D} || die
	dodoc ChkTeX.readme NEWS
	dohtml html/*
	doman chktex.1 chkweb.1
}
