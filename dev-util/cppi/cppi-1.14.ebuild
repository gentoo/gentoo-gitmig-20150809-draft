# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppi/cppi-1.14.ebuild,v 1.1 2010/03/04 16:19:24 jer Exp $

EAPI=3

DESCRIPTION="a cpp directive indenter"
HOMEPAGE="http://www.gnu.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS THANKS TODO
}
