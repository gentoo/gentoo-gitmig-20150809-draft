# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procinfo/procinfo-18.ebuild,v 1.13 2003/02/13 05:29:08 vapier Exp $

DESCRIPTION="A utility to prettyprint /proc/*"
SRC_URI="ftp://ftp.cistron.nl/pub/people/svm/${P}.tar.gz"
HOMEPAGE="ftp://ftp.cistron.nl/pub/people/svm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="sys-libs/ncurses"
RDEPEND="sys-devel/perl"

src_compile() {
	# -ltermcap is default and isn't available in gentoo
	# but -lncurses works just as good
	emake LDLIBS=-lncurses || die
}

src_install() {
	dobin procinfo
	newbin lsdev.pl lsdev
	newbin socklist.pl socklist
	
	doman *.8
	dodoc README CHANGES
}
