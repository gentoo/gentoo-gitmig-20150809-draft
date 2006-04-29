# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.4.1_pre20060122.ebuild,v 1.8 2006/04/29 15:31:18 metalgod Exp $

inherit wxwidgets flag-o-matic

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="aac amr debug ffmpeg jpeg mad mozilla ogg opengl oss png sdl ssl theora truetype vorbis wxwindows xml2 xvid"

S="${WORKDIR}/${PN}"

RDEPEND="aac? ( media-libs/faad2 )
	ffmpeg? ( media-video/ffmpeg )
	jpeg? ( media-libs/jpeg )
	mad? ( media-libs/libmad )
	mozilla? ( dev-lang/spidermonkey )
	mpeg? ( media-libs/faad2 )
	opengl? ( virtual/opengl )
	ogg? ( media-libs/libogg )
	png? ( media-libs/libpng )
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )
	truetype? ( >=media-libs/freetype-2.1 )
	wxwindows? ( >=x11-libs/wxGTK-2.6.0 )
	xml2? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	sdl? ( media-libs/libsdl )
		|| ( (
			x11-libs/libXt
			x11-libs/libX11
			x11-libs/libXext
		) virtual/x11 )"

DEPEND="${RDEPEND}"

pkg_setup() {
	if use ffmpeg; then
		myconf="${myconf} --use-ffmpeg=system"
	else
		myconf="${myconf} --use-ffmpeg=no"
	fi
	if use aac; then
		myconf="${myconf} --use-faad=system"
	else
		myconf="${myconf} --use-faad=no"
	fi
	if use jpeg; then
		myconf="${myconf} --use-jpeg=system"
	else
		myconf="${myconf} --use-jpeg=no"
	fi
	if use mad; then
		myconf="${myconf} --use-mad=system"
	else
		myconf="${myconf} --use-mad=no"
	fi
	if use mozilla; then
		myconf="${myconf} --use-js=system"
	else
		myconf="${myconf} --use-js=no"
	fi
	if use png; then
		myconf="${myconf} --use-png=system"
	else
		myconf="${myconf} --use-png=no"
	fi
	if use truetype; then
		myconf="${myconf} --use-ft=system"
	else
		myconf="${myconf} --use-ft=no"
	fi
	if use xvid; then
		myconf="${myconf} --use-xvid=system"
	else
		myconf="${myconf} --use-xvid=no"
	fi
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

}

src_compile() {
	cd ${S}
	chmod +x configure
	epatch ${FILESDIR}/gpac-${PV}-configure-ogg.patch || die "configure patch failed"
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
	if ! use mozilla; then
		sed -i -e 's/osmozilla//g' applications/Makefile
	fi
	# use this to cute down on the warnings noise
	append-flags -fno-strict-aliasing
	# amd64 compile
	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	./configure \
		--prefix=${D}/usr \
		--host=${CHOST} \
		--mandir=${D}/usr/share/man \
		--infodir=${D}/usr/share/info \
		--datadir=${D}/usr/share \
		--sysconfdir=${D}/etc \
		--localstatedir=${D}/var/lib \
		--enable-svg \
		$(use_enable amr) \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_enable oss oss-audio) \
		$(use_enable ssl) \
		${myconf} \
		die "configure died"

	make OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	make OPTFLAGS="${CFLAGS}" install || die
	make OPTLFAGS="${CFLAGS}" install-lib || die
	dodoc AUTHORS BUGS Changelog README TODO
	dodoc doc/*.html doc/*.txt doc/libisomedia_license doc/SGGen
}
