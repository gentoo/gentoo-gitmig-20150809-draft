# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.17.ebuild,v 1.3 2000/11/05 14:42:17 achim Exp $

P=BitchX-1.0c17
A=${P}.tar.gz
S=${WORKDIR}/BitchX
DESCRIPTION="A IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/${A}"
HOMEPAGE="http://www.bitchx.com/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_compile() {

    cd ${S}
    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--with-gtk --with-sound --prefix=/opt/gnome"
    else
	myopts="--prefix=/usr"
    fi
    try ./configure ${myopts} --host=${CHOST} \
	--enable-cdrom
    try make

}

src_install () {

    cd ${S}
    if [ -n "`use gnome`" ]
    then
      try make prefix=${D}/opt/gnome install
      insinto /opt/gnome/share/gnome/apps/Internet
      doins gtkBitchX.desktop
      insinto /opt/gnome/share/pixmaps
      doins BitchX.png
    else
      try make prefix=${D}/usr install
    fi
    dodoc Changelog README* IPv5-support
    cd doc
    insinto /usr/X11R6/include/bitmaps
    doins BitchX.xpm

    dodoc BitchX-* BitchX.bot *.doc BitchX.faq bitch52* README.hooks 
    dodoc bugs *.txt functions ideas mode plugins tcl-ideas watch
    dodoc *.tcl
    docinto html
    dodoc *.html
    doman ircII.1

}

