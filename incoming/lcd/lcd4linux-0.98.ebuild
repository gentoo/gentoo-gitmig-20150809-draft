# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp
# 21 Sept.2001 / 0.30 CET

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="system and ISDN information is shown on an external display or in a X11 window."
SRC_URI="http://download.sourceforge.net/lcd4linux/${A}"
HOMEPAGE="http://lcd4linux.sourceforge.net"

DEPEND=""

src_compile() {

    ./configure --with-drivers=all,\!PNG --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
    try make

}

src_install () {

    exeinto /usr/local/bin
    doexe lcd4linux 
    insinto /etc
    cp lcd4linux.conf.sample lcd4linux.conf 
    insopts -o root -g root -m 0600
    doins lcd4linux.conf
    dodoc README README.* ChangeLog COPYING INSTALL 
    dodoc lcd4kde.conf lcd4linux.conf.sample lcd4linux.kdelnk lcd4linux.xpm

  if [ "`use kde`" ] ; then
    insinto /etc
    insopts -o root -g root -m 0600
    doins lcd4kde.conf
    insinto /opt/kde2.2/share/applnk/apps/System
    doins lcd4linux.kdelnk 
    insinto /opt/kde2.2/share/icons
    doins lcd4linux.xpm 
    touch /etc/lcd4X11.conf 
  fi

}

