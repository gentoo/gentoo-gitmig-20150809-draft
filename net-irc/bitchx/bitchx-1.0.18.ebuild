# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.18.ebuild,v 1.1 2001/02/22 06:05:31 ryan Exp $

P=BitchX-1.0c18
A=${P}.tar.gz
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/${A}"
HOMEPAGE="http://www.bitchx.com/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_compile() {

    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--with-gtk --with-sound --prefix=/opt/gnome"
    else
	myopts="--prefix=/usr"
    fi
    try ./configure ${myopts} --host=${CHOST} \
	--enable-cdrom --with-plugins
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
    rm ${D}/usr/bin/BitchX
    ln -s ${D}/usr/bin/${P} BitchX
    dodoc Changelog README* IPv6-support
    cd doc
    insinto /usr/X11R6/include/bitmaps
    doins BitchX.xpm

    dodoc BitchX-* BitchX.bot *.doc BitchX.faq README.hooks 
    dodoc bugs *.txt functions ideas mode plugins tcl-ideas watch
    dodoc *.tcl
    docinto html
    dodoc *.html

}

