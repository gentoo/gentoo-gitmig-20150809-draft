# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.4.4.ebuild,v 1.2 2007/08/23 14:49:24 aballier Exp $

inherit eutils wxwidgets flag-o-matic multilib toolchain-funcs

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
NBV="610"
WBV="600"
PATCHLEVEL="2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCHLEVEL}.tar.bz2
	amr? ( http://www.3gpp.org/ftp/Specs/archive/26_series/26.104/26104-${NBV}.zip
		http://www.3gpp.org/ftp/Specs/archive/26_series/26.204/26204-${WBV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac alsa amr debug ffmpeg ipv6 jpeg jpeg2k javascript mad ogg opengl oss png sdl ssl theora truetype vorbis wxwindows xml xvid"

S="${WORKDIR}/${PN}"

RDEPEND="aac? ( >=media-libs/faad2-2.0 )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg )
	jpeg? ( media-libs/jpeg )
	javascript? ( >=dev-lang/spidermonkey-1.5 )
	mad? ( >=media-libs/libmad-0.15.1b )
	opengl? ( virtual/opengl )
	ogg? ( >=media-libs/libogg-1.1 )
	png? ( >=media-libs/libpng-1.2.5 )
	vorbis? ( >=media-libs/libvorbis-1.1 )
	theora? ( media-libs/libtheora )
	truetype? ( >=media-libs/freetype-2.1.4 )
	wxwindows? ( =x11-libs/wxGTK-2.6* )
	xml? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	sdl? ( media-libs/libsdl )
	jpeg2k? ( media-libs/openjpeg )
	x11-libs/libXt
	x11-libs/libX11
	x11-libs/libXext"

DEPEND="${RDEPEND}"

my_use() {
	local flag="$1" pflag="${2:-$1}"
	if use ${flag}; then
		echo "--use-${pflag}=system"
	else
		echo "--use-${pflag}=no"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"

	sed -ie '/ldconfig / d' "${S}/Makefile"

	if use amr; then
		cd modules/amr_float_dec
		unzip -jaq ${WORKDIR}/26104-${NBV}_ANSI_C_source_code.zip -d amr_nb_ft
		unzip -jaq ${WORKDIR}/26204-${WBV}_ANSI-C_source_code.zip -d amr_wb_ft
	fi

	cd "${S}"

	chmod +x configure
	# make sure configure looks for wx-2.6
	if use wxwindows; then
		WX_GTK_VER=2.6
		need-wxwidgets gtk2
		sed -i -e "s:wx-config:${WX_CONFIG}:g" configure
	else
		sed -i -e 's:^has_wx="yes:has_wx="no:' configure
	fi

	use sdl  || sed -i 's:^has_sdl=yes:has_sdl=no:' configure
	use alsa || sed -i 's:^has_alsa=yes:has_alsa=no:' configure

	# make sure mozilla won't be used
	sed -i -e 's/osmozilla//g' applications/Makefile

	# use this to cut down on the warnings noise
	append-flags -fno-strict-aliasing

	# multilib libdir fix
	sed -i -e 's:$(prefix)/lib:$(prefix)/'$(get_libdir)':' Makefile src/Makefile
	sed -i -e 's:/lib/gpac:/'$(get_libdir)'/gpac:' configure
}

src_compile() {
	if use ogg; then
		myconf="${myconf} --use-ogg=system"
		if use vorbis; then
			myconf="${myconf} --use-vorbis=system"
		fi
		if use theora; then
			myconf="${myconf} --use-theora=system"
		fi
	else
		myconf="${myconf} --use-ogg=no"
	fi

	econf \
		--enable-svg \
		--enable-pic \
		$(use_enable amr) \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_enable oss oss-audio) \
		$(use_enable ssl) \
		$(use_enable ipv6) \
		$(my_use ffmpeg) \
		$(my_use aac faad) \
		$(my_use jpeg) \
		$(my_use mad) \
		$(my_use javascript js) \
		$(my_use png) \
		$(my_use truetype ft) \
		$(my_use xvid) \
		$(my_use jpeg2k openjpeg) \
		${myconf} || die "configure died"

	emake -j1 CXX=$(tc-getCXX) CC=$(tc-getCC) OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	emake CXX=$(tc-getCXX) CC=$(tc-getCC) STRIP="true" INSTFLAGS="" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install || die
	emake CXX=$(tc-getCXX) CC=$(tc-getCC) STRIP="true" INSTFLAGS="" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install-lib || die
	dodoc AUTHORS BUGS Changelog README TODO
	dodoc doc/*.txt
	dohtml doc/*.html
}
