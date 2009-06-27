# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/undvd/undvd-0.7.5.ebuild,v 1.1 2009/06/27 12:37:46 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Simple dvd ripping command line app"
HOMEPAGE="http://sourceforge.net/projects/undvd/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac css ffmpeg matroska mp4 ogm xvid"

DEPEND="sys-apps/coreutils
	>=dev-lang/perl-5.8.8
	media-video/lsdvd
	media-video/mplayer[encode,dvd,mp3,x264,aac?,xvid?]
	css? ( media-libs/libdvdcss
		media-video/vobcopy )
	ffmpeg? ( media-video/ffmpeg )
	matroska? ( media-video/mkvtoolnix )
	mp4? ( media-video/mpeg4ip )
	ogm? ( media-sound/ogmtools )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
