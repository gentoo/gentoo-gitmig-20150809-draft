# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-1.64.ebuild,v 1.13 2003/07/04 15:50:16 gmsoft Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Perl script that converts Texinfo to HTML"

SRC_URI="http://www.mathematik.uni-kl.de/~obachman/Texi2html/Distrib/${P}.tar.gz"

HOMEPAGE="http://www.mathematik.uni-kl.de/~obachman/Texi2html/"
KEYWORDS="x86 ppc sparc alpha hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=dev-lang/perl-5.6.1"

src_compile() {

	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "Configuration Failed"
	
	emake || die "Parallel Make Failed"
	
}

src_install () {
	
	#yes, htmldir line is correct, no ${D}
	make DESTDIR=${D} \
		htmldir=/usr/share/doc/${PF}/html \
		install || die "Installation Failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL INTRODUCTION NEWS \
		README TODO

}
