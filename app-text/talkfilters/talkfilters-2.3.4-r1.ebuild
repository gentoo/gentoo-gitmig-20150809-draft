# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.3.4-r1.ebuild,v 1.3 2005/04/01 17:03:14 blubb Exp $

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
HOMEPAGE="http://www.dystance.net/software/talkfilters/"
SRC_URI="http://www.dystance.net/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# respect DESTDIR
	sed -i 's:\($(mandir)\):$(DESTDIR)/\1:' Makefile.am \
		|| die "sed Makefile.am failed"
	sed -i '/^AC_PROG_RANLIB$/d' configure.in || die "sed configure.in failed"
}

src_compile() {
	einfo "Running autoreconf"
	WANT_AUTOMAKE=1.7 autoreconf -f -i || die "autoreconf failed"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
