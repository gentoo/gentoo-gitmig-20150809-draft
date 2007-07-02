# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sidplay/sidplay-2.0.9.ebuild,v 1.6 2007/07/02 15:18:36 peper Exp $

IUSE=""

DESCRIPTION="C64 SID player"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${P}.tar.gz"
RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86 ~ppc sparc amd64"

RDEPEND=">=media-libs/libsidplay-2.1.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	make DESTDIR=${D} install || die
	dodoc TODO AUTHORS ChangeLog
}
