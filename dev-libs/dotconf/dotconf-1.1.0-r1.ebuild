# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dotconf/dotconf-1.1.0-r1.ebuild,v 1.4 2010/02/11 23:23:27 abcd Exp $

EAPI="2"

inherit eutils

DESCRIPTION="dot.conf libraries"
HOMEPAGE="http://www.azzit.de/dotconf/"
SRC_URI="http://www.azzit.de/dotconf/download/v1.1/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-dotconf-m4.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	einstall || die
}
