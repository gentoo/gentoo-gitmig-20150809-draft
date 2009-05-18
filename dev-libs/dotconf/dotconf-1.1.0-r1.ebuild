# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dotconf/dotconf-1.1.0-r1.ebuild,v 1.1 2009/05/18 18:16:42 williamh Exp $

EAPI="2"

inherit eutils

DESCRIPTION="dot.conf libraries"
HOMEPAGE="http://www.azzit.de/dotconf/"
SRC_URI="http://www.azzit.de/dotconf/download/v1.1/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-dotconf-m4.patch
}

src_configure() {
	econf --prefix=/usr || die
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	einstall || die
}
