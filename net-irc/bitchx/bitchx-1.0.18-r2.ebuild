# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.18-r2.ebuild,v 1.2 2001/06/01 14:00:14 achim Exp $

P=
A=ircii-pana-1.0c18.tar.gz
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/${A}"
HOMEPAGE="http://www.bitchx.com/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/openssl-0.9.6
	gnome? ( >=gnome-base/gnome-libs-1.2.4 
		 >=media-sound/esound-0.2.22 )"

src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--with-gtk --with-sound --prefix=/opt/gnome --with-esd"
    else
	myopts="--prefix=/usr"
    fi
    try ./configure ${myopts} --host=${CHOST} \
	--enable-cdrom --with-plugins
    try make

}

src_install () {

    if [ -n "`use gnome`" ]
    then
      try make prefix=${D}/opt/gnome install
#      insinto /opt/gnome/share/gnome/apps/Internet
#      doins gtkBitchX.desktop
#      insinto /opt/gnome/share/pixmaps
#      doins BitchX.png
      cd ${D}/opt/gnome/bin
      rm gtkBitchX
      ln -sf gtkBichX-1.0c18 gtkBitchX
      chmod -x ${D}/opt/gnome/lib/bx/plugins/BitchX.hints
    else
      try make prefix=${D}/usr install
      cd ${D}/usr/bin
      rm gtkBitchX
      ln -sf BichX-1.0c18 BitchX
      chmod -x ${D}/usr/lib/bx/plugins/BitchX.hints
    fi

    #ln -sf ${D}/usr/bin/${P} BitchX


    cd ${S}
    dodoc Changelog README* IPv6-support
    cd doc
    insinto /usr/X11R6/include/bitmaps
    doins BitchX.xpm

    dodoc BitchX-* BitchX.bot *.doc BitchX.faq README.hooks 
    dodoc bugs *.txt functions ideas mode tcl-ideas watch
    dodoc *.tcl
    docinto html
    dodoc *.html

    docinto plugins
    dodoc plugins
    cd ../dll
    insinto /usr/lib/bx/wav
    doins wavplay/*.wav
    cp acro/README acro/README.acro
    dodoc acro/README.acro
    cp arcfour/README arcfour/README.arcfour
    dodoc arcfour/README.arcfour
    cp blowfish/README blowfish/README.blowfish
    dodoc blowfish/README.blowfish
    dodoc nap/README.nap
    cp qbx/README qbx/README.qbx
    dodoc qbx/README.qbx
}
