# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.10.ebuild,v 1.8 2004/11/04 01:41:03 geoman Exp $

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile/"
SRC_URI="http://www.mega-nerd.com/libsndfile/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~ia64 sparc amd64 ~ppc64 ~ppc-macos ~mips"
IUSE="static pic"
DEPEND="virtual/libc"

src_compile() {
	( use pic || use amd64 ) && myconf="${myconf} --with-pic"
	myconf="${myconf} $(use_enable static)"
	econf $myconf  || die "./configure failed"

	# fix this weird doc installation directory libsndfile decides
	# to something more standard
	sed -e "s:^htmldocdir.*:htmldocdir = /usr/share/doc/${PF}/html:" -i ${S}/doc/Makefile

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO || die "dodoc failed"
}