# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@saintmail.net>

S=${WORKDIR}/${PN}-0.9.1.alpha
DESCRIPTION="DVD Navigator plugin for Xine."
SRC_URI="http://skyblade.homeip.net/xine/XINE-${PV}/source.TAR.BZ2s/xine-dvdnav-0.9.1.alpha.tar.bz2"
HOMEPAGE="http://dvd.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-0.0.3
	>=media-libs/libdvdread-0.9.1
	>=media-video/xine-lib-0.9.1"

RDEPEND="$DEPEND"


src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man || die
	make || die
	
}

src_install () {
	
	make  DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	
}

