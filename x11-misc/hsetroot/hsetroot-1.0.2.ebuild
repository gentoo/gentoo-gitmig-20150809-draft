# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hsetroot/hsetroot-1.0.2.ebuild,v 1.7 2006/01/13 13:37:23 nelchael Exp $

IUSE=""
DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
SRC_URI="http://thegraveyard.org/files/${P}.tar.gz"
HOMEPAGE="http://thegraveyard.org/hsetroot.php"

RDEPEND="|| ( (
			x11-libs/libX11
			x11-libs/libXext )
		virtual/x11 )
		>=media-libs/imlib2-1.0.6.2003
		>=media-libs/imlib2_loaders-1.0.4.2003"

DEPEND="${RDEPEND}
		|| ( (
			x11-proto/xproto
			x11-libs/libX11
			x11-libs/libXt )
		virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

src_compile() {
	econf || die
	emake all || die
}

src_install () {
	dobin src/hsetroot
	dodoc README
}
