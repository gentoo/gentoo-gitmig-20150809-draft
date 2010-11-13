# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-2.0.4.ebuild,v 1.5 2010/11/13 18:42:39 armin76 Exp $

EAPI=2
inherit libtool

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="gnome jpeg png"

COMMON_DEPEND=">=media-video/ffmpeg-0.5
	png? ( >=media-libs/libpng-1.4 )
	jpeg? ( virtual/jpeg )"
RDEPEND="${COMMON_DEPEND}
	gnome? ( >=gnome-base/gnome-vfs-2 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable png) \
		$(use_enable jpeg) \
		$(use_enable gnome gnome-vfs)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
