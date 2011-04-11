# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.5.4-r2.ebuild,v 1.3 2011/04/11 13:54:05 phajdan.jr Exp $

EAPI="2"

inherit cmake-utils flag-o-matic

MY_P=${PN}_${PV}

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ~ppc x86"
IUSE="+aac +aften +alsa amr +dts esd jack libsamplerate +mp3 nls oss
	pulseaudio +sdl +truetype +vorbis +x264 +xv +xvid gtk +qt4"

RDEPEND="dev-libs/libxml2
	aac? (
		media-libs/faac
		media-libs/faad2
	)
	aften? ( media-libs/aften[cxx] )
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	dts? ( media-libs/libdca )
	mp3? ( media-sound/lame )
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	libsamplerate? ( media-libs/libsamplerate )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl )
	truetype? (
		media-libs/freetype:2
		media-libs/fontconfig
	)
	vorbis? ( media-libs/libvorbis )
	x264? ( media-libs/x264 )
	xv? ( x11-libs/libXv )
	xvid? ( media-libs/xvid )
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}
BUILD_S=${WORKDIR}/${P}_build

AVIDEMUX_LANGS="bg ca cs de el es fr it ja pt_BR ru sr sr@latin tr zh_TW"
for L in ${AVIDEMUX_LANGS}; do
	IUSE="${IUSE} linguas_${L}"
done

PATCHES=(
	"${FILESDIR}/${P}-build-plugins-fix.patch"
	#bug 342909
	"${FILESDIR}/${P}-dummy-sound-fix.patch"
	#bug 356373
	"${FILESDIR}/${P}-x264-version-fix.patch"
)

src_prepare() {
	base_src_prepare

	local po_files=
	local qt_ts_files=
	local avidemux_ts_files=
	for lingua in ${LINGUAS}; do
		if has ${lingua} ${AVIDEMUX_LANGS}; then
			if [[ -e ${S}/po/${lingua}.po ]]; then
				po_files="${po_files} \${po_subdir}/${lingua}.po"
			fi
			if [[ -e ${S}/po/qt_${lingua}.ts ]]; then
				qt_ts_files="${qt_ts_files} \${ts_subdir}/qt_${lingua}.ts"
			fi
			if [[ -e ${S}/po/${PN}_${lingua}.ts ]]; then
				avidemux_ts_files="${avidemux_ts_files} \${ts_subdir}/${PN}_${lingua}.ts"
			fi
		fi
	done

	sed -i -e "s!FILE(GLOB po_files .*)!SET(po_files ${po_files})!" \
		"${S}/cmake/Po.cmake" || die "sed failed"
	sed -i -e "s!FILE(GLOB.*qt.*)!SET(ts_files ${qt_ts_files})!" \
	    -e "s!FILE(GLOB.*avidemux.*)!SET(ts_files ${avidemux_ts_files})!" \
		"${S}/cmake/Ts.cmake" || die "sed failed"
	#fix exec command wrt bug #316599 and #291453
	sed -i "/Exec/s:\[\$e\]::" ${PN}2-gtk.desktop
}

src_configure() {
	### Add lax vector typing for PowerPC
	if use ppc || use ppc64; then
		append-cflags "-flax-vector-conversions"
	fi

	mycmakeargs+="
		-DAVIDEMUX_SOURCE_DIR='${S}'
		-DAVIDEMUX_INSTALL_PREFIX='${BUILD_S}'
		-DAVIDEMUX_CORECONFIG_DIR='${BUILD_S}/config'
		$(cmake-utils_use gtk)
		$(cmake-utils_use qt4)
		$(cmake-utils_use nls GETTEXT)
		$(cmake-utils_use sdl)
		$(cmake-utils_use xv XVIDEO)
		$(cmake-utils_use alsa)
		$(cmake-utils_use esd)
		$(cmake-utils_use jack)
		$(cmake-utils_use oss)
		$(cmake-utils_use pulseaudio PULSEAUDIOSIMPLE)
		$(cmake-utils_use aften)
		$(cmake-utils_use mp3 LAME)
		$(cmake-utils_use aac FAAC)
		$(cmake-utils_use aac FAAD)
		$(cmake-utils_use vorbis)
		$(cmake-utils_use dts LIBDCA)
		$(cmake-utils_use amr OPENCORE_AMRNB)
		$(cmake-utils_use amr OPENCORE_AMRWB)
		$(cmake-utils_use truetype FREETYPE2)
		$(cmake-utils_use truetype FONTCONFIG)
		$(cmake-utils_use xvid)
		$(cmake-utils_use x264)
	"

	cmake-utils_src_configure
}

src_compile() {
	append-flags -D__STDC_FORMAT_MACROS
	# first build the application
	cmake-utils_src_compile
	# and then go on with plugins
	emake -C "${CMAKE_BUILD_DIR}/plugins" || die "building plugins failed"
}

src_install() {
	# install the application
	cmake-utils_src_install
	# install plugins
	emake -C "${CMAKE_BUILD_DIR}/plugins" DESTDIR="${D}" install \
		|| die "installing plugins failed"

	dodoc AUTHORS || die "dodoc failed"
	newicon ${PN}_icon.png ${PN}.png || die "installing icon failed"

	if use qt4; then
		sed -i "s/\(${PN}2_\)gtk/\1qt4/" ${PN}2.desktop || die "sed failed"
		domenu ${PN}2.desktop || die "installing desktop file failed"
	fi

	if use gtk; then
		domenu ${PN}2-gtk.desktop || die "installing desktop file failed"
	fi
}
