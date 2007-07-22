# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmifinfo/wmifinfo-0.09.ebuild,v 1.6 2007/07/22 05:02:19 dberkholz Exp $

IUSE=""

DESCRIPTION="WindowMaker Interface Monitor (dockapp)"
HOMEPAGE="http://www.zevv.nl/wmifinfo/"
SRC_URI="http://www.zevv.nl/wmifinfo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Allow use of Gentoo CFLAGS
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin wmifinfo
	dodoc README Changelog
}
