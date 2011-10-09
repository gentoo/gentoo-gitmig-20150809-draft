# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.6.2.ebuild,v 1.2 2011/10/09 17:37:14 ssuominen Exp $

EAPI=4

DESCRIPTION="A library used to extract metadata from files of arbitrary type"
HOMEPAGE="http://www.gnu.org/software/libextractor/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# waiting for gnunet
#KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome ffmpeg" # qt4 test

RDEPEND="app-arch/bzip2
	app-text/iso-codes
	app-text/poppler[cairo]
	dev-libs/glib:2
	gnome-extra/libgsf[gnome?]
	media-gfx/exiv2
	media-libs/flac
	media-libs/libmpeg2
	media-libs/libogg
	media-libs/libvorbis
	>=sys-devel/libtool-2.2.6b
	sys-libs/zlib
	virtual/libintl
	x11-libs/gtk+:2
	ffmpeg? ( virtual/ffmpeg )"
#	qt4? ( x11-libs/qt-gui:4 x11-libs/qt-svg:4 )
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"
#	test? ( app-forensics/zzuf )

# Disabled tests because they dont work (tester@g.o)
RESTRICT="test"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	econf \
		--enable-glib \
		--enable-gsf \
		$(use_enable gnome) \
		$(use_enable ffmpeg) \
		--without-qt
}

src_compile() {
	emake -j1
}

src_install() {
	default

	# keeping these for libltdl to load plugins
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
