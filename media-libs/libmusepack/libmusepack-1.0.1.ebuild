# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.0.1.ebuild,v 1.1 2004/09/05 22:14:42 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://perso.wanadoo.fr/reservoir/mpc/${S}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_unpack () {
	unpack ${A}

	cd ${S}
	sed -i 's:-O2 -march=i686 -pipe:${CFLAGS}:g' Makefile
}

src_compile() {
	emake || die "make failed"
}


src_install() {
	dodir /usr/include/musepack
	insinto /usr/include/musepack
	doins *.h
	dolib.so libmusepack.so.1.0.1
	dosym libmusepack.so.1.0.1 /usr/$(get_libdir)/libmusepack.so.1
}
