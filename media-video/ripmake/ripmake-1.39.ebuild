# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ripmake/ripmake-1.39.ebuild,v 1.1 2004/10/06 20:39:15 trapni Exp $

DESCRIPTION="This is a program to rip dvd to AVI/VCD/SVCD automagically using with optional use of cpdvd to copy a dvd to harddrive before transcoding"
HOMEPAGE="http://www.lallafa.de/bp/ripmake.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="dvd"
SLOT="0"

DEPEND="
	>=perl-5.6.1-r1
	>=transcode-0.6.10
	>=pgmfindclip-1.13
	>=chaplin-1.10
	>=ogmtools-1.0.1
	>=mjpegtools-1.6.0-r7
	>=toolame-02l
	>=sox-12.17.3-r3
	>=mpglen-0.1
	>=mkvtoolnix-0.7.1
	dvd? ( >=cpvts-1.2 )
	dvd? ( >=dvdbackup-0.1.1 )
	dvd? ( >=cpdvd-1.10 )
"
src_install() {
	dobin $S || die
}
