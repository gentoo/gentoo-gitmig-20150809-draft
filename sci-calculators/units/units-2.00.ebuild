# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-2.00.ebuild,v 1.1 2012/07/02 03:58:36 jer Exp $

EAPI=4
inherit eutils

DESCRIPTION="unit conversion program"
HOMEPAGE="http://www.gnu.org/software/units/units.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	>=sys-libs/readline-4.1-r2
	>=sys-libs/ncurses-5.2-r3
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc ChangeLog NEWS README
}
