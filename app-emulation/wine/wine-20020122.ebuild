# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20020122.ebuild,v 1.1 2002/03/02 16:58:22 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/Wine-${PV}.tar.gz"
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
    >=media-libs/freetype-2.0.0
    dev-lang/tcl dev-lang/tk"

src_compile() {
    
    cd ${S}
    local myconf

    use opengl	  && myconf="--enable-opengl"				|| myconf="--disable-opengl"
    [ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" 	|| myconf="$myconf --enable-trace --enable-debug"

    ./configure --prefix=/usr --sysconfdir=/etc/wine \
		--host=${CHOST} --enable-curses ${myconf} || die

    cd ${S}/programs/winetest
    cp Makefile 1
    sed -e 's:wine.pm:include/wine.pm:' 1 > Makefile
    
    cd ${S}	
    make depend all manpages || die
    cd programs && emake || die
    
}

src_install () {
    
    cd ${S}
    make prefix=${D}/usr install || die
    cd ${S}/programs
    make prefix=${D}/usr install || die
    
    # these .so's are strange. they are from the make in programs/ above,
    # and are for apps built with winelib (windows sources built directly
    # against wine). Apparently the sources go into a <program name>.so file
    # and you run it via a symlink <program name> -> wine. Unfortunately both
    # the symlink and the .so apparently must reside in /usr/bin.
    cd ${D}/usr/bin
    chmod a-x *.so
        
    cd ${S}
    dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README WARRANTY
    
    cd ${S}/documentation
    doman man3w/*
    doman *.man
    dohtml *.sgml
    
    insinto /etc/wine
    doins samples/*
    
    dodir /etc/skel/.wine
    dosym /etc/wine/config /etc/skel/.wine/config
    
}

pkg_postinst() {

    einfo "If you are installing wine for the first time,
copy /etc/wine/config (global configuration) to ~/.wine/config
and edit that for per-user configuration. Otherwise, wine will
not run.
Also, run \"regapi setValue < /etc/wine/winedefault.reg\" to setup
per-user registry for using wine. More info in /usr/share/doc/wine-${PV}."

}
