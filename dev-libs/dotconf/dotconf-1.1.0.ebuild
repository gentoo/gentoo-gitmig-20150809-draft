# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dotconf/dotconf-1.1.0.ebuild,v 1.12 2009/03/23 05:22:59 williamh Exp $

inherit eutils

DESCRIPTION="dot.conf libraries"
HOMEPAGE="http://www.azzit.de/dotconf/"
SRC_URI="http://www.azzit.de/dotconf/download/v1.1/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc sparc x86"
IUSE=""
DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_compile() {
	econf --prefix=/usr || die
	emake CC=$(tc-getCC) || die
}

src_install() {
	einstall || die
}
