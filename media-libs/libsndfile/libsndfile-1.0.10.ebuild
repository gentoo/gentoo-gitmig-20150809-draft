# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.10.ebuild,v 1.2 2004/07/16 17:46:29 chriswhite Exp $

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile/"
SRC_URI="http://www.mega-nerd.com/libsndfile/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~ia64 ~sparc ~amd64"
IUSE="static pic"
DEPEND="virtual/libc"

src_compile() {
	myconf="${myconf} $(use_with pic pic)"
	myconf="${myconf} $(use_enable static static)"
	econf $myconf  || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO || die "dodoc failed"
}
