# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.2.1.ebuild,v 1.1 2005/03/30 17:14:02 chriswhite Exp $

inherit wxwidgets flag-o-matic

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
LVER=0.1.3
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	amr? ( mirror://sourceforge/${PN}/${PN}_extra_libs-${LVER}_linux.tar.gz )
	divx4linux? ( mirror://sourceforge/${PN}/${PN}_extra_libs-${LVER}_linux.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="amr debug divx4linux jpeg mad mozilla mpeg oss png sdl truetype xml2 xvid"
S=${WORKDIR}/${PN}

DEPEND="jpeg? ( media-libs/jpeg )
	mad? ( media-libs/libmad )
	mozilla? ( dev-lang/spidermonkey )
	mpeg? ( media-libs/faad2
		>=media-video/ffmpeg-0.4.9_pre1 )
	png? ( media-libs/libpng )
	truetype? ( >=media-libs/freetype-2.1 )
	xml2? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	sdl? (media-libs/libsdl)"

src_unpack() {
	unpack ${A}
	use divx4linux && \
		mv gpac_extra_libs/opendivx/* gpac/Plugins/OpenDivx/divx
	# audio codec used in 3GP
	use amr && \
		mv gpac_extra_libs/amr_nb gpac/Plugins/amr_dec/AMR_NB
}

src_compile() {
	#enable wxwindows entirely as we can't
	#use it because of package masking
	sed -i 's:^has_wx="yes:has_wx="no:' configure

	use !sdl && sed -i 's:^has_sdl=yes:has_sdl=no:' configure

	# fix hardcoded paths in source
	sed -i -e \
		"s:\([^f]\)\ M4_PLUGIN_PATH:\1 \"/usr/$(get_libdir)\":" \
		Applications/MP4Client/main.c \
		Applications/Osmo4_wx/wxOsmo4.cpp \
		|| die "path fixation failed"

	# use this to cute down on the warnings noise
	append-flags -fno-strict-aliasing

	./configure \
		--prefix=${D}/usr \
		--host=${CHOST} \
		--mandir=${D}/usr/share/man \
		--infodir=${D}/usr/share/info \
		--datadir=${D}/usr/share \
		--sysconfdir=${D}/etc \
		--localstatedir=${D}/var/lib \
		$(use_enable amr amr-nb) \
		$(use_enable debug) \
		$(use_enable divx4linux opendivx) \
		$(use_enable mpeg faad) \
		$(use_enable mpeg ffmpeg) \
		$(use_enable jpeg) \
		$(use_enable mad) \
		$(use_enable mozilla js) \
		$(use_enable oss oss-audio) \
		$(use_enable png) \
		$(use_enable truetype ft) \
		$(use_enable xvid) ||
		die "configure died"

	make OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	make OPTFLAGS="${CFLAGS}" install || die

	dodoc AUTHORS BUGS Changelog INSTALL README TODO
	dodoc doc/*.html doc/*.txt doc/libisomedia_license doc/SGGen
}
