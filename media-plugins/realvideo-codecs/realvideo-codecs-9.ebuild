# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/realvideo-codecs/realvideo-codecs-9.ebuild,v 1.2 2004/01/16 10:46:11 liquidx Exp $

RESTRICT="nostrip"

DESCRIPTION="RealVideo 9 Codecs Add-on for RealPlayer 8"
HOMEPAGE="http://realforum.real.com/cgi-bin/unixplayer/showthreaded.pl?Cat=&Board=announcements&Number=3128&page=0&view=collapsed&sb=5"
SRC_URI="http://docs.real.com/docs/playerpatch/unix/rv9_libc6_i386_cs2.tgz"

LICENSE="realplayer8"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha"
IUSE=""

RDEPEND=">=media-video/realplayer-8"

BASE="/opt/RealPlayer8"
S=${WORKDIR}

src_compile() {
	return
}

src_install () {
	insinto ${BASE}/Codecs
	doins rv9/codecs/drv4.so.6.0 rv9/codecs/rv40.so.6.0
}
