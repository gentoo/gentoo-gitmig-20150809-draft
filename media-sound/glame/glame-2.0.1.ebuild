# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-2.0.1.ebuild,v 1.14 2009/06/21 16:02:20 ssuominen Exp $

EAPI=2
WANT_AUTOCONF=2.5
inherit autotools eutils

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="+alsa +gnome vorbis"

RDEPEND=">=dev-scheme/guile-1.8[deprecated]
	>=dev-libs/libxml-1.8
	>=dev-libs/libxml2-2
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	=sci-libs/fftw-2*
	media-libs/libmad
	media-libs/ladspa-sdk
	vorbis? ( >=media-libs/libvorbis-1 )
	gnome? ( >=gnome-base/libglade-2
		>=gnome-base/libgnome-2.6
		>=gnome-base/libgnomecanvas-2.6
		>=x11-libs/gtk+-2.6
		>=gnome-base/libgnomeui-2.6 )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	use gnome || ewarn "You will need to emerge with USE gnome to get a GUI."
}

src_prepare() {
	cd libltdl
	eautoconf
	cd ..
	epatch "${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-guile_1_8_compat.patch
}

src_configure() {
	econf \
		$(use_enable gnome gui) \
		$(use_enable alsa alsatest) \
		--enable-ladspa
}

src_install() {
	einstall || die "einstall failed"
	use gnome && dosym ../glame/pixmaps/glame-logo.jpg /usr/share/pixmaps/${PN}.jpg
	dodoc AUTHORS BUGS CREDITS ChangeLog MAINTAINERS NEWS README TODO
}
