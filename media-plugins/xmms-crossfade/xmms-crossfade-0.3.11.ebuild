# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-crossfade/xmms-crossfade-0.3.11.ebuild,v 1.2 2006/09/06 02:21:01 metalgod Exp $

inherit eutils

IUSE=""

DESCRIPTION="XMMS Plugin for crossfading, and continuous output."
HOMEPAGE="http://www.eisenlohr.org/${PN}/index.html"
SRC_URI="http://www.eisenlohr.org/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms"

src_compile() {
	econf --libdir=`xmms-config --output-plugin-dir` || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
pkg_postinst () {
	ewarn "If you're using the ARTS output plugin, set the 'Limit OP buffer"
	ewarn "usage' to 400ms in the 'Advanced' tab of XMMS-crossfade's"
	ewarn "configuration dialog. This will eliminate the worst"
	ewarn "of the distorted/skipped output."
}
