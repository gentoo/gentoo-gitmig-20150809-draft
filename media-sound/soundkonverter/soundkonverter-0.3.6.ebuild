# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-0.3.6.ebuild,v 1.3 2008/04/24 17:34:12 drac Exp $

inherit kde eutils qt3

DESCRIPTION="SoundKonverter: a frontend to various audio converters for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php?content=29024"
SRC_URI="http://hessijames.googlepages.com/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg flac kdeenablefinal mp3 musepack vorbis"

DEPEND=">=media-libs/taglib-1.4
	>=media-sound/cdparanoia-3.9.8-r5
	$(qt_min_version 3)"
RDEPEND="mp3? ( >=media-sound/lame-3.96 )
	vorbis? ( >=media-sound/vorbis-tools-1 )
	flac? ( >=media-libs/flac-1.1.1 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	musepack? ( >=media-sound/musepack-tools-1.15u )"

need-qt 3
need-kde 3.5

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	append-flags -fno-inline
	local myconf="--without-mp4v2
			$(use_enable kdeenablefinal final)
			$(use_with arts)"
	kde_src_compile || die "kde_src_compile failed."
}

src_install() {
	kde_src_install || die "kde_src_install failed."
	mv "${D}"/usr/share/doc/HTML "${D}"/usr/share/doc/${PF}/html
}

pkg_postinst() {
	elog "The audio USE flags are for your convience, but are not required."
	elog "For AmaroK users there is a script included with this package."
	elog "You can enable it with the Script Manager tool in Amarok, after"
	elog "installing kde-base/qtruby."
}
