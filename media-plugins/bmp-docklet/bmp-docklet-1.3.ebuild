# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-docklet/bmp-docklet-1.3.ebuild,v 1.2 2005/08/23 22:21:00 chainsaw Exp $

DESCRIPTION="BMP plugin displays a icon in your systemtray"
SRC_URI="http://mark.xnull.de/${PN}/${P}.tar.bz2"
HOMEPAGE="http://mark.xnull.de/bmp-docklet.php"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="nls"

RDEPEND=">=media-sound/beep-media-player-0.9.7-r5"
DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO
}
