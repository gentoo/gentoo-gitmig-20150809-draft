# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgadu/libgadu-20040820.ebuild,v 1.2 2004/08/22 21:03:32 sekretarz Exp $

inherit eutils libtool

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://dev.null.pl/ekg"
SRC_URI="http://dev.gentoo.org/~sekretarz/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6m )"

#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
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
