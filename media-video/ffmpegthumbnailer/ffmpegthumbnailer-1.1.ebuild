# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-1.1.ebuild,v 1.3 2007/03/31 18:00:43 armin76 Exp $

inherit eutils

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	media-video/ffmpeg"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-int.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}
