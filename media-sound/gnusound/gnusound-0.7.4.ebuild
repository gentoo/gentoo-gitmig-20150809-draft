# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnusound/gnusound-0.7.4.ebuild,v 1.7 2007/09/23 11:40:17 drac Exp $

WANT_ATUOMAKE=1.8
WANT_AUTOCONF=2.5

inherit toolchain-funcs eutils autotools

IUSE="3dnow alsa audiofile cpudetection flac ffmpeg jack lame libsamplerate mmx
ogg oss sse vorbis"

PATCHLEVEL="1"
M4TARBALL_REV="1"
DESCRIPTION="GNUsound is a sound editor for Linux/x86"
HOMEPAGE="http://gnusound.sourceforge.net/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCHLEVEL}.tar.bz2
	mirror://gentoo/${P}-m4-${M4TARBALL_REV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -sparc ~x86"

DEPEND=">=gnome-base/libglade-2.0.1
	>=gnome-base/libgnomeui-2.2.0.1
	audiofile? ( >=media-libs/audiofile-0.2.3 )
	flac? ( media-libs/flac )
	ffmpeg? ( media-video/ffmpeg )
	ogg? ( media-libs/libogg )
	lame? ( media-sound/lame )
	media-libs/libsndfile
	vorbis? ( media-libs/libvorbis )
	libsamplerate? ( media-libs/libsamplerate )"

pkg_setup() {
	required_audio_drivers="alsa jack oss"
	ok=false
	for i in $required_audio_drivers; do
		use $i && ok=true
	done
	if test "$ok" = "false"; then
		die "In order to run ${PN}, you must enable at least one of those use flags: ${required_audio_drivers}"
	fi
}
src_unpack() {
	unpack ${A} || die "unpack failure"
	cd "${S}" || die "workdir not found"

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	cp "${WORKDIR}"/m4/* config/
	epatch "${FILESDIR}"/${P}-gtk212.patch
	AT_M4DIR="config" eautoreconf
}

src_compile() {
	myconf="--disable-fastmemcpy"
	use mmx && use sse && use 3dnow && myconf="--enable-fastmemcpy"
	# Doesnt detect gnome2 if sndfile is off
	econf \
		$(use_enable audiofile) \
		$(use_enable lame) \
		--enable-sndfile \
		$(use_enable ogg) \
		$(use_enable vorbis) \
		$(use_enable ffmpeg) \
		--disable-gmerlin \
		$(use_enable flac) \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_with libsamplerate) \
		$(use_enable cpudetection) \
		$(use_enable mmx fastminmax) \
		${myconf} \
		--with-gnome2 \
		|| die "Configure failure"
	emake CC=$(tc-getCC) || die "Make failure"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README NOTES TODO CHANGES
}
