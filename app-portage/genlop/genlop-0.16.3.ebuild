# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.16.3.ebuild,v 1.7 2003/11/16 17:37:38 vapier Exp $

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://freshmeat.net/projects/genlop/"
SRC_URI="http://pollycoke.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
RESTRICT="nostrip"

DEPEND="app-arch/tar
	app-arch/gzip"
RDEPEND=">=dev-lang/perl-5.8.0-r10"

src_install() {
	dobin genlop
	dodoc README
}
