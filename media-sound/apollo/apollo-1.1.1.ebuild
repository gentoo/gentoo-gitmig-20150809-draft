# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/apollo/apollo-1.1.1.ebuild,v 1.1 2001/09/15 23:06:03 karltk Exp $

S=${WORKDIR}/${P}-1

DESCRIPTION="A Qt-based front-end to mpg123"

SRC_URI="http://prdownloads.sourceforge.net/apolloplayer/apollo-src-1.1.1-1.tar.bz2"

HOMEPAGE="http://www.apolloplayer.org"

DEPEND=">=x11-libs/qt-x11-2.3.0"

RDEPEND=">=media-sound/mpg123-0.59r"

src_unpack() {

   cd ${WORKDIR}
   unpack apollo-src-1.1.1-1.tar.bz2
   cd ${S}
   mv install.sh install.sh.orig
   cat install.sh.orig | sed -e 's:$PREFIX/local:$PREFIX:g' > install.sh
}

src_compile() {

    QTDIR=/usr/X11R6/lib/qt make
    
}

src_install () {
    local myconf
    if [ "`use kde`" ]
    then
        # FIXME: won't work when multiple versions of KDE is installed
    	foo=`/opt/kde*/bin/kde-config --prefix`
        myconf="--with-kde=${D}$foo"
        dodir opt/kde/share/applnk/Multimedia
    fi
    
    dodir usr/bin
    echo `pwd`
    sh install.sh --prefix=${D}/usr $myconf
    
}

