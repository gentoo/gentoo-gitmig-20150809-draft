# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@hotmail.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.3-r2.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


#P=
A="vnc-3.3.3r2_unixsrc.tgz"
S=${WORKDIR}/vnc_unixsrc
DESCRIPTION=""
SRC_URI="http://www.uk.research.att.com/vnc/dist/${A}"
HOMEPAGE="http://www.uk.research.att.com/vnc/index.html"

DEPEND=""

src_compile() {

    cd ${S}
    cd Xvnc/config/cf
    mv Imake.cf Imake.cf.orig
    #insist that the machine is an i386 for the Xvnc build
    sed -e '/#ifdef linux/a\# define i386' Imake.cf.orig > Imake.cf
    cd ${S}
    try xmkmf
    try make World
    cd Xvnc
    try make World

}

src_install () {

    cd ${S}
    mkdir -p ${D}/usr/bin
    try ./vncinstall ${D}/usr/bin

}

