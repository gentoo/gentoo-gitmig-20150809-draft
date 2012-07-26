# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.9.13.ebuild,v 1.6 2012/07/26 17:07:13 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.nongnu.org/g-wrap/"
SRC_URI="http://download.savannah.gnu.org/releases/g-wrap/${P}.tar.gz"
KEYWORDS="~alpha amd64 hppa ~ppc ~ppc64 ~sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# guile-lib for srfi-34, srfi-35
RDEPEND="
	dev-libs/glib:2
	dev-scheme/guile-lib
	dev-scheme/guile[deprecated]
	virtual/libffi"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/indent"

MAKEOPTS+=" -j1"

src_configure() {
	econf --disable-Werror --with-glib
}
