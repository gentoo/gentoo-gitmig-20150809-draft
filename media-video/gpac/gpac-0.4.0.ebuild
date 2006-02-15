# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.4.0.ebuild,v 1.3 2006/02/15 15:43:33 flameeyes Exp $

inherit wxwidgets flag-o-matic eutils

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
NBV="610"
WBV="600"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	amr? ( http://www.3gpp.org/ftp/Specs/archive/26_series/26.104/26104-${NBV}.zip
		http://www.3gpp.org/ftp/Specs/archive/26_series/26.204/26204-${WBV}.zip )"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/gpac"
ECVS_MODULE="gpac"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="amr debug jpeg mad ffmpeg javascript aac ogg vorbis oss png sdl theora
truetype wxwindows xml2 xvid mozilla"
S=${WORKDIR}/${PN}

RDEPEND="jpeg? ( media-libs/jpeg )
	mad? ( media-libs/libmad )
	mozilla? ( dev-lang/spidermonkey )
	aac? ( media-libs/faad2 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_pre1 )
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )
	png? ( media-libs/libpng )
	truetype? ( >=media-libs/freetype-2.1 )
	sdl? ( media-libs/libsdl )
	xml2? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	wxwindows? ( >=x11-libs/wxGTK-2.5.2 )"

DEPEND="${RDEPEND}
	amr? ( app-arch/unzip )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-downloader.patch

	# disable wxwindows entirely as we can't
	# use it because of package masking
	if use wxwindows; then
		WX_GTK_VER="2.6"
		need-wxwidgets gtk2
		sed -i "s:wx-config:${WX_CONFIG}:g" configure
	fi

	use !sdl && sed -i -e 's:^has_sdl=yes:has_sdl=no:' configure

	# make configure to pick theora, if presented
	use theora && sed -i -e 's:-ltheora 2:`pkg-config --libs theora` 2:' configure

	if use amr; then
		cd Plugins/amr_float_dec
		unzip -jaq ${WORKDIR}/26104-${NBV}_ANSI_C_source_code.zip -d AMR_NB_FT
		unzip -jaq ${WORKDIR}/26204-${WBV}_ANSI-C_source_code.zip -d AMR_WB_FT
	fi
}

src_compile() {
	# avoid miscompilation
	append-flags -fno-strict-aliasing

	/bin/sh ./configure \
		--prefix=${D}/usr \
		--host=${CHOST} \
		--mandir=${D}/usr/share/man \
		--infodir=${D}/usr/share/info \
		--datadir=${D}/usr/share \
		--sysconfdir=${D}/etc \
		--localstatedir=${D}/var/lib \
		$(use_enable amr) \
		$(use_enable debug) \
		$(use_enable aac faad) \
		$(use_enable ffmpeg ) \
		$(use_enable jpeg) \
		$(use_enable mad) \
		$(use_enable javascript js) \
		$(use_enable oss oss-audio) \
		$(use_enable png) \
		$(use_enable truetype ft) \
		$(use_enable xml2 svg) \
		$(use_enable xvid) ||
		die "configure failed"

	make OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	make DISTDIR="${D}" install || die

	dodoc AUTHORS BUGS Changelog INSTALL README TODO
	dodoc doc/*.html doc/*.txt doc/libisomedia_license doc/SGGen
	dolib.a bin/gcc/libm4systems_static.a
	insinto /usr/include/gpac
	doins include/gpac/*.h
}
