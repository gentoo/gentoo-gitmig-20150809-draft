# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mytharchive/mytharchive-0.20.1_p13375.ebuild,v 1.2 2007/06/12 15:52:49 cardoe Exp $

inherit mythtv-plugins

SRC_URI="${SRC_URI}
		http://dev.gentoo.org/~cardoe/files/mythtv/mytharchive-newfiles-11564.tar.bz2"
DESCRIPTION="Allows for archiving your videos to DVD."
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND=">=dev-lang/python-2.3.5
		dev-python/mysql-python
		dev-python/imaging
		<media-video/mjpegtools-1.8.99999
		>=media-video/mjpegtools-1.6.2
		>=media-video/dvdauthor-0.6.11
		>=media-video/ffmpeg-0.4.9
		>=app-cdr/dvd+rw-tools-5.21.4.10.8
		virtual/cdrtools
		media-video/transcode"
DEPEND="${RDEPEND}"

pkg_setup()
{
	mythtv-plugins_pkg_setup

	if ! built_with_use media-video/mjpegtools png; then
		eerror "You MUST build media-video/mjpegtools with the png USE flag"
		die "You MUST build media-video/mjpegtools with the png USE flag"
	fi
}
