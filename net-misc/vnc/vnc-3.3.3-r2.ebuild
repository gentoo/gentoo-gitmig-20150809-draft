# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@hotmail.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.3-r2.ebuild,v 1.4 2001/09/03 23:58:33 blocke Exp $


#P=
A="vnc-3.3.3r2_unixsrc.tgz"
S=${WORKDIR}/vnc_unixsrc
DESCRIPTION=""
SRC_URI="http://www.uk.research.att.com/vnc/dist/${A}"
HOMEPAGE="http://www.uk.research.att.com/vnc/index.html"

DEPEND=""

src_compile() {

    #imake and the vnc build process possess amazing suckage skills
    #hoping some poor developer takes pitty on vnc and fixes it

    cd ${S}
    cd Xvnc/config/cf
    mv Imake.cf Imake.cf.orig
    #insist that the machine is an i386 for the Xvnc build
    sed -e '/#ifdef linux/a\# define i386' Imake.cf.orig > Imake.cf
    cd ${S}
    try xmkmf

    #FIXME: my dirty little fix to fix imake brain damage
    try make Makefiles
    try make depend
    cp ${FILESDIR}/vncviewer-makefile-3.3.3r2 ${S}/vncviewer/Makefile

    try make all

    #FIXME: Xvnc build doesn't respect user CFLAGS settings
    cd Xvnc
    try make World

}

src_install () {

    cd ${S}
    mkdir -p ${D}/usr/X11R6/bin
    try ./vncinstall ${D}/usr/X11R6/bin

}

