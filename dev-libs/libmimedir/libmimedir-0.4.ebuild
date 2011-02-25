# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmimedir/libmimedir-0.4.ebuild,v 1.4 2011/02/25 21:56:17 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Library for manipulating MIME directory profiles (RFC2425)"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/bison
	sys-devel/flex"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-distdir.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
