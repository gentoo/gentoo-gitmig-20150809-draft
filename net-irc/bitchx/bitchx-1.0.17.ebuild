# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.17.ebuild,v 1.2 2000/10/09 16:02:49 achim Exp $

P=BitchX-1.0c17
A=${P}.tar.gz
S=${WORKDIR}/BitchX
DESCRIPTION="A IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/${A}"
HOMEPAGE="http://www.bitchx.com/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--with-gtk --enable-sound --enable-cdrom
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 install
    prepman /usr/X11R6
    dodoc Changelog README* IPv6-support
    cd doc
    insinto /usr/X11R6/include/bitmaps
    doins BitchX.xpm
    insinto /opt/gnome/share/gnome/apps/Internet
    doins gtkBitchX.desktop
    insinto /opt/gnome/share/pixmaps
    doins BitchX.png
    dodoc BitchX-* BitchX.bot *.doc BitchX.faq bitch52* README.hooks 
    dodoc bugs *.txt functions ideas mode plugins tcl-ideas watch
    dodoc *.tcl
    docinto html
    dodoc *.html
    doman ircII.1

}

