# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20010418.ebuild,v 1.2 2001/06/03 22:39:52 blutgens Exp $

WSV=0.5.1b
A="Wine-${PV}.tar.gz winesetuptk-${WSV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/${A}
	 http://wine.codeweavers.com/~mpilka/winesetuptk/winesetuptk-${WSV}.tar.gz"
HOMEPAGE="http://www.winehq.com/
	  http://wine.codeweavers.com/winesetuptk.shtml"

DEPEND="virtual/glibc
        virtual/x11
        >=sys-libs/ncurses-5.2
        opengl? ( virtual/opengl )"

RDEPEND="${DEPEND}
	 >=dev-lang/tcl-tk-8.4.2
	 >=dev-tcltk/itcl-3.2"

src_compile() {
    
    cd ${S}
    local myconf
    if [ "`use opengl`" ]
    then
        myconf="--enable-opengl"
    else
        myconf="--disable-opengl"
    fi
    try ./configure --prefix=/opt/wine --sysconfdir=/etc/opt/wine \
	--host=${CHOST} ${myconf}

    try make depend
    try make
    
    cd ${WORKDIR}/winesetuptk-${WSV}
    ./configure --prefix=/opt/wine --with-launcher=/opt/wine/bin \
	--with-data=/opt/wine/share/winesetuptk --with-doc=/opt/wine/share/doc/winesetuptk
}

src_install () {
    
    try make prefix=${D}/opt/wine install
    insinto /etc/opt/wine
    doins ${FILESDIR}/wine.conf
    dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE
    dodoc README WARRANTY
    
    cd ${WORKDIR}/winesetuptk-${WSV}
    make PREFIX_BIN=${D}/opt/wine/bin \
	 PREFIX_SRC=${D}/opt/wine/share/winesetuptk \
	 PREFIX_DOC=${D}/opt/wine/share/doc/winesetuptk \
	 cw-install install
    cd doc ; docinto winesetuptk-${WSV}
    dodoc CHANGELOG.TXT LICENSE.TXT README.TXT
    cd development_doc ; docinto winesetuptk-${WSV}/development_doc
    dodoc CHANGELOG.TXT global_cfg_db_members.txt
    
    insinto /etc/env.d
    newins ${FILESDIR}/wine.env 90wine
}

