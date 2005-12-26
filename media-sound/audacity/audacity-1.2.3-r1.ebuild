# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.2.3-r1.ebuild,v 1.5 2005/12/26 14:38:49 lu_zero Exp $

inherit wxwidgets eutils

IUSE="gtk2 encode flac mad vorbis libsamplerate"

MY_PV="${PV/_/-}"
MY_P="${PN}-src-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# amd64: causes xfce pannel to crash...
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc64"

DEPEND="=x11-libs/wxGTK-2.4*
	>=app-arch/zip-2.3
	>=media-libs/id3lib-3.8.0
	media-libs/libid3tag
	>=media-libs/libsndfile-1.0.0
	libsamplerate? ( >=media-libs/libsamplerate-0.0.14 )
	>=media-libs/ladspa-sdk-1.12
	flac? ( media-libs/flac )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	mad? ( media-libs/libmad )
	encode? ( >=media-sound/lame-3.92 )"

WX_GTK_VER="2.4"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}"/${P}-x86.patch #bug #73248
}

src_compile() {
	if ! use gtk2; then
		need-wxwidgets gtk || die "No gtk1 version of x11-libs/wxGTK found"
	else
		need-wxwidgets gtk2 || die "No gtk2 version of x11-libs/wxGTK found"
	fi

	econf \
		$(use_with mad libmad system) \
		$(use_with vorbis vorbis system) \
		$(use_with flac libflac system) \
		$(use_with libsamplerate system) \
		--with-id3tag=system \
		--with-libsndfile=system \
		${myconf} || die

	# parallel borks
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Install our docs
	dodoc LICENSE.txt README.txt audacity-1.2-help.htb

	# Remove bad doc install
	rm -rf ${D}/share/doc

	insinto /usr/share/icons/hicolor/48x48/apps
	newins images/AudacityLogo48x48.xpm audacity.xpm

	make_desktop_entry audacity Audacity audacity

	# remove the eventual desktop file in applnk.
	rm -rf ${D}/usr/share/applnk
}
