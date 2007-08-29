# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mytharchive/mytharchive-0.20.2_p14282.ebuild,v 1.2 2007/08/29 15:08:20 cardoe Exp $

inherit mythtv-plugins subversion

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
