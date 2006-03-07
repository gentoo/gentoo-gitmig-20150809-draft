# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsndfile/libsndfile-1.0.9.ebuild,v 1.11 2006/03/07 11:18:29 flameeyes Exp $

inherit eutils

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile/"
SRC_URI="http://www.mega-nerd.com/libsndfile/${P}.tar.gz"

KEYWORDS="x86 ~ppc ~alpha ~ia64 sparc amd64 ppc64"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epunt_cxx
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}

src_test() { :; }
