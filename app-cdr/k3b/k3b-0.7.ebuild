# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.7.ebuild,v 1.4 2002/07/22 01:39:12 lostlogic Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="K3b, KDE CD Writing Software"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.gz"
HOMEPAGE="http://k3b.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	>=media-libs/id3lib-3.8.0_pre2
	>=media-sound/mad-0.14.2b-r1
	media-video/transcode
	media-libs/libvorbis"

myconf="$myconf --enable-sso"
[ -n "$DEBUG" ] && myconf="$myconf --enable-debugging --enable-profiling" || myconf="$myconf --disable-debugging --disable-profiling"

src_compile() {

    kde_src_compile myconf configure
    
    cd ${S}
    for x in Makefile src/Makefile; do
	mv $x $x.orig
	sed -e 's:CDPARANOIA_LIBS = =:CDPARANOIA_LIBS = -lcdda_interface -lcdda_paranoia:' $x.orig > $x
    done
    
    kde_src_compile make

}

src_install() {

    dodir ${KDEDIR}/share/apps/k3b/pics
    
    kde_src_install

}
