# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.3.4.ebuild,v 1.1 2005/01/15 20:17:15 ka0ttic Exp $

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
HOMEPAGE="http://www.dystance.net/software/talkfilters/"
SRC_URI="http://www.dystance.net/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	sys-devel/flex
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:\($(mandir)\):$(DESTDIR)/\1:' Makefile.am || die "sed failed"
}

src_compile() {
	automake || die "automake failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
