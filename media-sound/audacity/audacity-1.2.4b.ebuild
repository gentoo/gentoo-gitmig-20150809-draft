# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.2.4b.ebuild,v 1.1 2006/01/01 04:21:00 matsuu Exp $

inherit wxwidgets eutils

IUSE="encode flac ladspa libsamplerate mad mp3 soundtouch vorbis"

MY_P="${PN}-src-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# amd64: causes xfce pannel to crash...
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="=x11-libs/wxGTK-2.4*
	>=app-arch/zip-2.3
	>=media-libs/libsndfile-1.0.0
	media-libs/libid3tag
	media-libs/portaudio
	encode? ( >=media-sound/lame-3.92 )
	flac? ( media-libs/flac )
	ladspa? ( >=media-libs/ladspa-sdk-1.12 )
	libsamplerate? ( >=media-libs/libsamplerate-0.0.14 )
	mad? ( >=media-libs/libmad-0.14.2b )
	vorbis? ( >=media-libs/libvorbis-1.0 )"

#	nyquist? ( media-sound/nyquist )
#	portmixer? ( media-sound/portmixer )
#	resample? ( media-sound/libresample )
#	!resample? ( libsamplerate? ( >=media-libs/libsamplerate-0.0.14 ) )
#	soundtouch? ( media-libs/libsoundtouch )

WX_GTK_VER="2.4"

pkg_setup() {
	if ! built_with_use '=x11-libs/wxGTK-2.4*' wxgtk1 ; then
		eerror "${P} requires =x11-libs/wxGTK-2.4* emerged with USE='wxgtk1'"
		die "${P} requires =x11-libs/wxGTK-2.4* emerged with USE='wxgtk1'"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.3-x86.patch # bug 73248
	epatch "${FILESDIR}"/${PN}-1.2.3-gcc41.patch # bug 113754
}

src_compile() {
	local myconf

	myconf="${myconf} --with-libsndfile=system"

	need-wxwidgets gtk

	econf \
		$(use_with mad libmad system) \
		$(use_with vorbis vorbis system) \
		$(use_with flac libflac system) \
		$(use_with libsamplerate samplerate system) \
		$(use_with mp3 id3tag system) \
		$(use_with soundtouch) \
		${myconf} || die

	# parallel borks
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf ${D}/usr/share/doc

	# Install our docs
	dodoc README.txt audacity-1.2-help.htb

	insinto /usr/share/icons/hicolor/48x48/apps
	newins images/AudacityLogo48x48.xpm audacity.xpm

	make_desktop_entry audacity Audacity audacity
}
