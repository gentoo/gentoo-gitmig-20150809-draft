# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-1.64.ebuild,v 1.19 2004/12/03 03:30:02 usata Exp $

DESCRIPTION="Perl script that converts Texinfo to HTML"
SRC_URI="http://www.mathematik.uni-kl.de/~obachman/Texi2html/Distrib/${P}.tar.gz"
HOMEPAGE="http://www.mathematik.uni-kl.de/~obachman/Texi2html/"
LICENSE="GPL-2"

KEYWORDS="x86 ppc sparc alpha hppa amd64"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	>=dev-lang/perl-5.6.1"

src_compile() {
	econf || die "Configuration Failed"
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

pkg_preinst() {
	rm -f ${ROOT}usr/bin/texi2html
}
