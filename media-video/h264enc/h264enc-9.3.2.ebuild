# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/h264enc/h264enc-9.3.2.ebuild,v 1.1 2011/01/26 21:11:53 spatz Exp $

EAPI=3

DESCRIPTION="Script to encode H.264/AVC/MPEG-4 Part 10 formats"
HOMEPAGE="http://h264enc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac dvd flac lame matroska mp4 ogm vorbis"

RDEPEND="media-video/mplayer[encode,x264]
	aac? ( media-libs/faac
		media-sound/aacplusenc )
	flac? ( media-libs/flac )
	dvd? ( media-video/lsdvd )
	vorbis? ( media-sound/vorbis-tools )
	lame? ( media-sound/lame )
	matroska? ( media-video/mkvtoolnix )
	ogm? ( media-sound/ogmtools )
	mp4? ( >=media-video/gpac-0.4.5[a52] )
	sys-apps/coreutils
	sys-process/time
	sys-devel/bc
	sys-apps/pv"
DEPEND=""

src_install() {
	dobin ${PN} || die "dobin failed"
	doman man/${PN}.1 || die "doman failed"
	dodoc doc/* || die "dodoc failed"
	docinto matrices
	dodoc matrices/* || die "dodoc failed"
}
