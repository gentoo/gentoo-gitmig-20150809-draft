# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/undvd/undvd-0.7.5.ebuild,v 1.5 2010/04/27 12:27:00 ssuominen Exp $

EAPI=2

DESCRIPTION="Simple dvd ripping command line app"
HOMEPAGE="http://sourceforge.net/projects/undvd/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="css ffmpeg matroska ogm xvid"

RDEPEND="sys-apps/coreutils
	>=dev-lang/perl-5.8.8
	media-video/lsdvd
	media-video/mplayer[encode,dvd,mp3,x264,xvid?]
	css? ( media-libs/libdvdcss
		media-video/vobcopy )
	ffmpeg? ( media-video/ffmpeg )
	matroska? ( media-video/mkvtoolnix )
	ogm? ( media-sound/ogmtools )"
DEPEND=""

src_install() {
	emake DESTDIR="${D}" DOC="/usr/share/doc/${PF}" \
		install || die
}
