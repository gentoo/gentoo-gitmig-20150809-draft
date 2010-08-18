# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-2.0.1.ebuild,v 1.1 2010/08/18 13:41:29 scarabeus Exp $

EAPI=2
WEBKIT_REQUIRED=always
KDE_LINGUAS="ast be bg ca ca@valencia cs csb da de el en_GB eo es et eu fi fr ga
gl he hi hne hr hu is it ja km ko ku lt mai nb nds nl nn oc pa pl pt pt_BR ro ru
se sk sl sv th tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="The CD/DVD Kreator for KDE"
HOMEPAGE="http://www.k3b.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug dvd emovix encode ffmpeg flac mad lame musepack musicbrainz sndfile sox taglib vcd vorbis +wav"

DEPEND=">=kde-base/libkcddb-${KDE_MINIMAL}
	media-libs/libsamplerate
	dvd? ( media-libs/libdvdread )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	flac? ( >=media-libs/flac-1.2[cxx] )
	encode? ( lame? ( media-sound/lame ) )
	mad? ( media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	musicbrainz? ( media-libs/musicbrainz:1 )
	sndfile? ( media-libs/libsndfile )
	taglib? ( >=media-libs/taglib-1.5 )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}
	sys-apps/hal
	app-cdr/cdrdao
	media-sound/cdparanoia
	virtual/cdrtools
	dvd? ( >=app-cdr/dvd+rw-tools-7
		encode? ( media-video/transcode[dvd] ) )
	emovix? ( media-video/emovix )
	encode? ( sox? ( media-sound/sox ) )
	vcd? ( media-video/vcdimager )"

DOCS="ChangeLog FAQ PERMISSIONS README RELEASE_HOWTO"

S=${WORKDIR}/${P/_*}

src_configure() {
	mycmakeargs+=( "-DK3B_BUILD_K3BSETUP=OFF"
		$(cmake-utils_use debug K3B_DEBUG)
		$(cmake-utils_use musicbrainz K3B_ENABLE_MUSICBRAINZ)
		$(cmake-utils_use dvd K3B_ENABLE_DVD_RIPPING)
		$(cmake-utils_use taglib K3B_ENABLE_TAGLIB)
		"-DK3B_BUILD_API_DOCS=OFF"
		$(cmake-utils_use ffmpeg K3B_BUILD_FFMPEG_DECODER_PLUGIN)
		$(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_DECODER_PLUGIN)
		$(cmake-utils_use mad K3B_BUILD_MAD_DECODER_PLUGIN)
		$(cmake-utils_use musepack K3B_BUILD_MUSE_DECODER_PLUGIN)
		$(cmake-utils_use flac K3B_BUILD_FLAC_DECODER_PLUGIN)
		$(cmake-utils_use sndfile K3B_BUILD_SNDFILE_DECODER_PLUGIN)
		$(cmake-utils_use wav K3B_BUILD_WAVE_DECODER_PLUGIN)
		$(cmake-utils_use encode K3B_BUILD_EXTERNAL_ENCODER_PLUGIN) )

	if use encode; then
		mycmakeargs+=( $(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_ENCODER_PLUGIN)
			$(cmake-utils_use lame K3B_BUILD_LAME_ENCODER_PLUGIN)
			$(cmake-utils_use sox K3B_BUILD_SOX_ENCODER_PLUGIN) )
	fi

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "We don't install k3bsetup anymore because Gentoo doesn't need it."
	elog "If you get warnings on start-up, uncheck the \"Check system"
	elog "configuration\" option in the \"Misc\" settings window."
	echo

	local group=cdrom
	use kernel_linux || group=operator
	elog "Make sure you have proper read/write permissions on the cdrom device(s)."
	elog "Usually, it is sufficient to be in the ${group} group."
	echo
}
