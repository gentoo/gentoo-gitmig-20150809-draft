# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.6.3.ebuild,v 1.4 2012/05/05 08:02:42 jdhore Exp $

EAPI=4
inherit flag-o-matic multilib toolchain-funcs

DESCRIPTION="A library used to extract metadata from files of arbitrary type"
HOMEPAGE="http://www.gnu.org/software/libextractor/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~sparc x86"
IUSE="ffmpeg gsf qt4" # test

RDEPEND="app-arch/bzip2
	app-text/iso-codes
	app-text/poppler[cairo]
	>=dev-libs/glib-2
	media-gfx/exiv2
	media-libs/flac
	media-libs/libmpeg2
	media-libs/libogg
	media-libs/libvorbis
	>=sys-devel/libtool-2.2.6b
	sys-libs/zlib
	virtual/libintl
	x11-libs/gtk+:2
	ffmpeg? ( >=virtual/ffmpeg-0.6.90 )
	gsf? ( >=gnome-extra/libgsf-1.14.21 )
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-svg:4
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"
# test? ( app-forensics/zzuf )

RESTRICT="test"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	sed -i \
		-e 's:CODEC_TYPE_VIDEO:AVMEDIA_TYPE_VIDEO:' \
		src/plugins/thumbnailffmpeg_extractor.c || die
}

src_configure() {
	local myconf

	if use qt4; then
		append-cppflags "$($(tc-getPKG_CONFIG) --cflags-only-I QtGui QtSvg)"
		append-ldflags "$($(tc-getPKG_CONFIG) --libs-only-L QtGui QtSvg)"
	else
		myconf="--without-qt"
	fi

	econf \
		--enable-glib \
		$(use_enable gsf) \
		--disable-gnome \
		$(use_enable ffmpeg) \
		${myconf}
}

src_compile() {
	emake -j1
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
