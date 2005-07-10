# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgadu/libgadu-20040820.ebuild,v 1.7 2005/07/10 01:03:30 swegener Exp $

inherit eutils libtool

DESCRIPTION="This library implements the client side of the Gadu-Gadu protocol"
HOMEPAGE="http://dev.null.pl/ekg"
SRC_URI="http://dev.gentoo.org/~sekretarz/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6m )"

src_compile() {
	aclocal -I m4
	autoheader
	autoconf
	elibtoolize
	econf \
	    --enable-shared \
	    --with-pthread \
	    `use_with ssl openssl` \
	     || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die
}
