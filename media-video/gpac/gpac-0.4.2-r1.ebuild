# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.4.2-r1.ebuild,v 1.3 2006/12/21 14:26:09 corsair Exp $

inherit eutils wxwidgets flag-o-matic multilib toolchain-funcs

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
NBV="610"
WBV="600"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2
	amr? ( http://www.3gpp.org/ftp/Specs/archive/26_series/26.104/26104-${NBV}.zip
		http://www.3gpp.org/ftp/Specs/archive/26_series/26.204/26204-${WBV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~x86"
IUSE="aac amr debug ffmpeg jpeg javascript mad ogg opengl oss png sdl ssl theora truetype vorbis wxwindows xml xvid"

S="${WORKDIR}/${PN}"

RDEPEND="aac? ( media-libs/faad2 )
	ffmpeg? ( media-video/ffmpeg )
	jpeg? ( media-libs/jpeg )
	javascript? ( dev-lang/spidermonkey )
	mad? ( media-libs/libmad )
	opengl? ( virtual/opengl )
	ogg? ( media-libs/libogg )
	png? ( media-libs/libpng )
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )
	truetype? ( >=media-libs/freetype-2.1 )
	wxwindows? ( >=x11-libs/wxGTK-2.6.0 )
	xml? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	sdl? ( media-libs/libsdl )
		|| ( (
			x11-libs/libXt
			x11-libs/libX11
			x11-libs/libXext
		) virtual/x11 )"

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

	epatch "${WORKDIR}/${P}-configure-ogg.patch"
	epatch "${WORKDIR}/${P}-DESTDIR.patch"
	epatch "${WORKDIR}/${P}-static-defs.patch"
	epatch "${WORKDIR}/${P}-nostrip.patch"
	epatch "${WORKDIR}/${P}-soname.patch"
	epatch "${WORKDIR}/${P}-ffmpeg-snapshots-compat.patch"
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
		sed -i -e 's/wx-config/wx-config-2.6/' configure
	else
		sed -i 's:^has_wx="yes:has_wx="no:' configure
	fi

	use !sdl && sed -i 's:^has_sdl=yes:has_sdl=no:' configure

	# fix hardcoded paths in source
	sed -i -e \
		"s:\([^f]\)\ M4_PLUGIN_PATH:\1 \"/usr/$(get_libdir)\":" \
		applications/mp4client/main.c \
		applications/osmo4_wx/wxOsmo4.cpp \
		|| die "path fixation failed"

	# make sure mozilla won't be used
	sed -i -e 's/osmozilla//g' applications/Makefile

	# use this to cute down on the warnings noise
	append-flags -fno-strict-aliasing

	# multilib libdir fix
	sed -i 's:$(prefix)/lib:$(prefix)/'$(get_libdir)':' Makefile src/Makefile
	sed -i 's:/lib/gpac:/'$(get_libdir)'/gpac:' configure

	epatch "${WORKDIR}/${P}-pic.patch"
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
		$(use_enable amr) \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_enable oss oss-audio) \
		$(use_enable ssl) \
		$(my_use ffmpeg) \
		$(my_use aac faad) \
		$(my_use jpeg) \
		$(my_use mad) \
		$(my_use javascript js) \
		$(my_use png) \
		$(my_use truetype ft) \
		$(my_use xvid) \
		${myconf} || die "configure died"

	make CC=$(tc-getCC) OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	make OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install || die
	make OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install-lib || die
	dodoc AUTHORS BUGS Changelog README TODO
	dodoc doc/*.html doc/*.txt doc/libisomedia_license doc/SGGen
}
