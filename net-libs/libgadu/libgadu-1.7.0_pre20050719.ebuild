# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgadu/libgadu-1.7.0_pre20050719.ebuild,v 1.1 2006/10/09 19:50:13 sekretarz Exp $

inherit eutils libtool

# This ebuild will be removed soon
VER="20050719"

DESCRIPTION="This library implements the client side of the Gadu-Gadu protocol"
HOMEPAGE="http://dev.null.pl/ekg"
SRC_URI="http://dev.gentoo.org/~sekretarz/distfiles/${PN}-${VER}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 ~sparc x86"

IUSE="ssl threads"

S=${WORKDIR}/${PN}-${VER}

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6m )"

src_compile() {
	aclocal -I m4
	autoheader
	autoconf
	elibtoolize
	econf \
	    --enable-shared \
	    `use_with threads pthread` \
	    `use_with ssl openssl` \
	     || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die
}
