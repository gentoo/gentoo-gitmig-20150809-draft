# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.5-r1.ebuild,v 1.1 2002/06/01 19:56:38 danarmak Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/${P}-kde3
DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/arson/${P}-kde3.tar.bz2"
HOMEPAGE="http://arson.sourceforge.net/"

newdepend ">=media-sound/cdparanoia-3.9.8
	   >=media-sound/bladeenc-0.94.2
	   app-cdr/cdrtools
	   oggvorbis? ( media-libs/libvorbis )"
	   
use oggvorbis && myconf="$myconf --with-vorbis" || myconf="$myconf --without-vorbis"

src_compile() {

    # fancy kde2/3 build scheme
    cd ${S}
    need-autoconf 2.1
    ./util kde3
    kde_src_compile

}
