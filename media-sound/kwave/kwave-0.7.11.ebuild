# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.7.11.ebuild,v 1.1 2008/07/25 13:26:00 carlo Exp $

EAPI=1

inherit kde-functions flag-o-matic

MY_P="${P}-1"

DESCRIPTION="Kwave is a sound editor for KDE."
HOMEPAGE="http://kwave.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwave/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="alsa arts bindist debug flac mp3 ogg oss"

RDEPEND="arts? ( || ( kde-base/kdemultimedia-arts:3.5 kde-base/kdemultimedia:3.5 ) )
	alsa? ( media-libs/alsa-lib )
	media-libs/audiofile
	mp3? ( media-libs/id3lib media-libs/libmad )
	ogg? ( media-libs/libogg media-libs/libvorbis )
	flac? ( media-libs/flac )
	sci-libs/gsl"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6
	|| ( kde-base/kdesdk-misc:3.5 kde-base/kdesdk:3.5 )
	app-text/recode
	media-gfx/imagemagick"
need-kde 3.5

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/kwave-0.7.11-desktop-entry-fix.diff" \
		"${FILESDIR}/kwave-0.7.11-build-script-fix.diff"
}

src_compile() {
	# Work around the build script picking up KDE 4 binaries.
	export PATH="${KDEDIR}/bin:${PATH}"

	myconf="-DWITH_BUILTIN_LIBAUDIOFILE=OFF"
	use alsa  || myconf+=" -DWITH_ALSA=OFF"
	use arts  && myconf+=" -DWITH_ARTS=ON"
	use flac  || myconf+=" -DWITH_FLAC=OFF"
	use mp3   || myconf+=" -DWITH_MP3=OFF"
	use ogg   || myconf+=" -DWITH_OGG=OFF"
	use oss   || myconf+=" -DWITH_OSS=OFF"
	use debug || myconf+=" -DDEBUG=ON --debug-output"

	LDFLAGS="${LDFLAGS}" cmake \
		-DCMAKE_INSTALL_PREFIX=/usr			\
		-DCMAKE_BUILD_TYPE=Release			\
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC))	\
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX))	\
		-DCMAKE_CXX_FLAGS="-DQT_THREAD_SUPPORT"		\
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS}"	\
		-DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS}"		\
		${myconf} \
	|| die "cmake failed"

	emake || die "Error: emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
