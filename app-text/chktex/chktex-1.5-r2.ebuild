# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chktex/chktex-1.5-r2.ebuild,v 1.10 2002/12/09 04:17:43 manson Exp $

S=${WORKDIR}/${P}
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/chktex/"
SLOT="0"
DESCRIPTION="Checks latex source for common mistakes"
DEPEND="app-text/tetex
	sys-devel/perl
	sys-apps/groff
	app-text/latex2html"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

src_compile() {
	myconf="--prefix=/usr --host=${CHOST}"
	[ -n "$DEBUG" ] && myconf="$myconf --enable-debug-info" || myconf="$myconf --disable-debug-info"
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc COPYING SCOPTIONS
}
