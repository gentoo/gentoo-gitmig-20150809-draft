# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.3.4-r1.ebuild,v 1.8 2007/01/04 13:30:35 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
HOMEPAGE="http://www.dystance.net/software/talkfilters/"
SRC_URI="http://www.dystance.net/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc ~ppc-macos x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	# respect DESTDIR
	sed -i 's:\($(mandir)\):$(DESTDIR)/\1:' Makefile.am \
		|| die "sed Makefile.am failed"
	sed -i '/^AC_PROG_RANLIB$/d' configure.in || die "sed configure.in failed"

	eautoreconf
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
