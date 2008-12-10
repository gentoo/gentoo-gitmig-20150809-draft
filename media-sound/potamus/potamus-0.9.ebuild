# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/potamus/potamus-0.9.ebuild,v 1.2 2008/12/10 16:51:43 ssuominen Exp $

inherit eutils gnome2-utils

DESCRIPTION="a lightweight audio player with a simple interface and an emphasis on high audio quality."
HOMEPAGE="http://offog.org/code/potamus.html"
SRC_URI="http://offog.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	media-libs/libao
	media-libs/libsamplerate
	media-libs/libvorbis
	media-libs/libmad
	media-libs/audiofile
	media-libs/libmodplug
	>=media-video/ffmpeg-0.4.9_p20080326
	media-libs/flac
	media-libs/bio2jack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ffmpeg.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS README TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
