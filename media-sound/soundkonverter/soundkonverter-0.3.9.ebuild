# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-0.3.9.ebuild,v 1.2 2009/05/14 04:58:31 ssuominen Exp $

EAPI=1
ARTS_REQUIRED=never
inherit autotools flag-o-matic kde

DESCRIPTION="SoundKonverter: A frontend to various audio converters for KDE."
HOMEPAGE="http://kde-apps.org/content/show.php?content=29024"
SRC_URI="http://hessijames.googlepages.com/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg flac mp3 musepack vorbis"

DEPEND="media-libs/taglib
	media-sound/cdparanoia"
RDEPEND="${DEPEND}
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	ffmpeg? ( media-video/ffmpeg )
	musepack? ( media-sound/musepack-tools )"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-desktop_entry.patch" "${FILESDIR}/${P}-gcc44.patch" )

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	append-flags -fno-inline
	local myconf="--without-mp4v2"
	kde_src_compile
}

src_install() {
	kde_src_install
	mv "${D}"/usr/share/doc/HTML "${D}"/usr/share/doc/${PF}/html
}

pkg_postinst() {
	kde_pkg_postinst

	elog "The audio USE flags are for your convience, but are not required."
	elog "For AmaroK users there is a script included with this package."
	elog "You can enable it with the Script Manager tool in Amarok, after"
	elog "installing kde-base/qtruby."
}
