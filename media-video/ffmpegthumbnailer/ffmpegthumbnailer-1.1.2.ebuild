# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-1.1.2.ebuild,v 1.9 2007/08/18 21:16:45 drac Exp $

inherit autotools eutils

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/libpng
	>=media-video/ffmpeg-0.4.9_p20070330"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ffmpeg.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}
