# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dotconf/dotconf-1.1.0.ebuild,v 1.7 2008/01/11 16:22:48 jer Exp $

DESCRIPTION="dot.conf libraries"
HOMEPAGE="http://www.azzit.de/dotconf/"
SRC_URI="http://www.azzit.de/dotconf/download/v1.1/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86"
IUSE=""
DEPEND=">=sys-devel/autoconf-2.58
	>=sys-devel/make-3.80"

src_compile() {
	econf --prefix=/usr || die
	emake || die
}

src_install() {
	einstall || die
}
