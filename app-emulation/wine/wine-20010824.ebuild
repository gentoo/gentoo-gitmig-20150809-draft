# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20010824.ebuild,v 1.1 2001/08/31 13:40:32 danarmak Exp $

A="Wine-${PV}.tar.gz" #winesetuptk-${WSV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/${A}"
	 #http://twine.codeweavers.com/~mpilka/winesetuptk/winesetuptk-${WSV}.tar.gz"
HOMEPAGE="http://www.winehq.com/"
	  #http://wine.codeweavers.com/winesetuptk.shtml"

# need to add: db2html, db2ps, db2pdf for building the docs
DEPEND="virtual/glibc
    virtual/x11
	sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
    opengl? ( virtual/opengl )
    >=sys-libs/ncurses-5.2
	net-print/cups
	>=media-libs/freetype-2.0.0"

src_compile() {
    
    cd ${S}
    local myconf

    if [ "`use opengl`" ]
    then
        myconf="--enable-opengl"
    else
        myconf="--disable-opengl"
    fi

    if [ -z $DEBUG ]
    then
	  myconf="$myconf --disable-trace --disable-debug"
    else
	  myconf="$myconf --enable-trace --enable-debug"
    fi

    ./configure --prefix=/opt/wine --sysconfdir=/etc/opt/wine \
		--infodir=/opt/info --mandir=/opt/man \
		--host=${CHOST} --enable-curses ${myconf} || die
		
    make depend || die
    make || die
    
}

src_install () {
    
    make prefix=${D}/opt/wine install || die
    insinto /etc/opt/wine
    newins ${FILESDIR}/wine.conf config
    dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README WARRANTY
    
    insinto /etc/env.d
    newins ${FILESDIR}/wine.env 90wine
	
}

