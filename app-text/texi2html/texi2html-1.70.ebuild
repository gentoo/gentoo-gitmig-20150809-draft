# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-1.70.ebuild,v 1.3 2004/11/22 15:18:42 vapier Exp $

DESCRIPTION="Perl script that converts Texinfo to HTML"
HOMEPAGE="https://texi2html.cvshome.org/"
SRC_URI="https://texi2html.cvshome.org/files/documents/70/173/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-lang/perl-5.6.1"

src_install() {
	#yes, htmldir line is correct, no ${D}
	make DESTDIR=${D} \
		htmldir=/usr/share/doc/${PF}/html \
		install || die "Installation Failed"

	dodoc AUTHORS ChangeLog INSTALL INTRODUCTION NEWS README TODO
}
