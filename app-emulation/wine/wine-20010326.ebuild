# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20010326.ebuild,v 1.2 2001/04/23 19:59:23 drobbins Exp $

A=Wine-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/${A}"
HOMEPAGE="http://www.winehq.com"

DEPEND="virtual/glibc
        virtual/x11
         >=sys-libs/ncurses-5.2
         opengl? ( media-libs/mesa-glu )"

src_compile() {

    local myconf
    if [ "`use opengl`" ]
    then
        myconf="--enable-opengl"
    else
        myconf="--disable-opengl"
    fi
    try ./configure --prefix=/usr --libdir=/usr/lib/wine --sysconfdir=/etc/wine \
	--host=${CHOST} ${myconf}

    try make depend
    try make

}

src_install () {

    try make prefix=${D}/usr libdir=${D}/usr/lib/wine mandir=${D}/usr/share/man install
    insinto /etc/wine
    doins ${FILESDIR}/wine.conf
    dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE
    dodoc README WARRANTY

}

