# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/apollo/apollo-1.1.1-r1.ebuild,v 1.7 2002/07/08 04:05:36 drobbins Exp $
 
use kde && inherit kde-base

S=${WORKDIR}/${P}-1
LICENSE="GPL-2"
DESCRIPTION="A Qt-based front-end to mpg123"
SRC_URI="mirror://sourceforge/apolloplayer/apollo-src-1.1.1-1.tar.bz2"
HOMEPAGE="http://www.apolloplayer.org"
KEYWORDS="*"

use kde && need-kde 2.2 && need-qt 2.3

RDEPEND="$RDEPEND >=media-sound/mpg123-0.59r"
use kde || DEPEND="$DEPEND =x11-libs/qt-2.3*"

src_unpack() {

   cd ${WORKDIR}
   unpack apollo-src-1.1.1-1.tar.bz2
   cd ${S}
   mv install.sh install.sh.orig
   cat install.sh.orig | sed -e 's:$PREFIX/local:$PREFIX:g' -e 's:BINDIR=$dir::' > install.sh
}

src_compile() {

    make || die "died making"
    
}

src_install () {

    if [ "`use kde`" ]
    then
        myconf="$myconf --with-kde=${D}/${KDEDIR}"
    fi
    
    dodir usr/bin
    echo `pwd`
    sh install.sh --prefix=${D}/usr $myconf
    
}

