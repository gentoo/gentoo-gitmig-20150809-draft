# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sidplay/sidplay-2.0.9.ebuild,v 1.10 2009/05/21 22:01:07 jer Exp $

inherit eutils

DESCRIPTION="C64 SID player"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsidplay-2.1.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc TODO AUTHORS ChangeLog
}
