# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-1.64-r1.ebuild,v 1.2 2004/02/17 21:24:50 agriffis Exp $

IUSE=""

inherit alternatives

DESCRIPTION="Perl script that converts Texinfo to HTML"
HOMEPAGE="http://www.mathematik.uni-kl.de/~obachman/Texi2html/"
SRC_URI="http://www.mathematik.uni-kl.de/~obachman/Texi2html/Distrib/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~amd64 ia64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=dev-lang/perl-5.6.1"

S=${WORKDIR}/${P}

src_compile() {

	econf --program-suffix=-${PV} || die "Configuration Failed"
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

pkg_postinst() {

	alternatives_auto_makesym "/usr/bin/texi2html" "/usr/bin/texi2html-*"
}
