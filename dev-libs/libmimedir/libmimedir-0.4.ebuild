# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmimedir/libmimedir-0.4.ebuild,v 1.1 2006/01/11 06:29:23 chriswhite Exp $

inherit eutils autotools

DESCRIPTION="Library for manipulating MIME directory profiles (RFC2425)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="sys-devel/flex
	sys-devel/bison"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-distdir.patch
	eautoreconf
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README
}
