# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mytharchive/mytharchive-0.20_p12824.ebuild,v 1.3 2007/04/16 14:23:27 cardoe Exp $

inherit mythtv-plugins

SRC_URI="${SRC_URI}
		http://dev.gentoo.org/~cardoe/files/mythtv/mytharchive-newfiles-11564.tar.bz2"
DESCRIPTION="Allows for archiving your videos to DVD."
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND=">=dev-lang/python-2.3.5
		dev-python/mysql-python
		dev-python/imaging
		>=media-video/mjpegtools-1.6.2
		<media-video/mjpegtools-1.8.99999
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

src_unpack()
{
	mythtv-plugins_src_unpack

	cd "${S}"
	rm -f mytharchive/mythburn/music/funky1.mp2
	rm -f mytharchive/mythburn/music/funky2.mp2
	rm -f mytharchive/mythburn/music/menumusic.mp2
	rm -f mytharchive/mythburn/music/silence.mp2
	mv ../mytharchive/images/ma_updown.png mytharchive/images/ma_updown.png
	mv ../mytharchive/mythburn/intro/ntsc_blank.mpg mytharchive/mythburn/intro/ntsc_blank.mpg
	mv ../mytharchive/mythburn/intro/pal_blank.mpg mytharchive/mythburn/intro/pal_blank.mpg
	mv ../mytharchive/mythburn/music/funky1.ac3 mytharchive/mythburn/music/funky1.ac3
	mv ../mytharchive/mythburn/music/funky2.ac3 mytharchive/mythburn/music/funky2.ac3
	mv ../mytharchive/mythburn/music/menumusic.ac3 mytharchive/mythburn/music/menumusic.ac3
	mv ../mytharchive/mythburn/music/silence.ac3 mytharchive/mythburn/music/silence.ac3
}
