# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ripmake/ripmake-1.39.ebuild,v 1.3 2004/11/30 22:17:56 swegener Exp $

IUSE="dvd"

S="${WORKDIR}"

DESCRIPTION="This is a program to rip dvd to AVI/VCD/SVCD automagically using with optional use of cpdvd to copy a dvd to harddrive before transcoding"
SRC_URI="http://www.lallafa.de/bp/files/${P}.gz"
HOMEPAGE="http://www.lallafa.de/bp/ripmake.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.1-r1
	>=media-video/transcode-0.6.10
	>=media-video/pgmfindclip-1.13
	>=media-video/chaplin-1.10
	>=media-sound/ogmtools-1.0.1
	>=media-video/mjpegtools-1.6.0-r7
	>=media-sound/toolame-02l
	>=media-sound/sox-12.17.3-r3
	>=media-video/mpglen-0.1
	>=media-video/mkvtoolnix-0.7.1
	dvd? ( >=media-video/cpvts-1.2
	       >=media-video/dvdbackup-0.1.1
	       >=media-video/cpdvd-1.10 )"

src_install() {
	newbin ${P} ${PN} || die
}
