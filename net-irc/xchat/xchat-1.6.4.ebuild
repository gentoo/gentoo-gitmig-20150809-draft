# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.6.4.ebuild,v 1.2 2001/06/05 19:43:20 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.6/"${A}
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=gnome-base/gdk-pixbuf-0.11.0 nls? ( >=sys-devel/gettext-0.10.38 )
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
        ssl? ( >=dev-libs/openssl-0.9.6a )"

RDEPEND=">=gnome-base/gdk-pixbuf-0.11.0
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 ) ssl? ( >=dev-libs/openssl-0.9.6a )"

src_unpack() {
  unpack ${A}
  cd ${S}/po
  cp zh_TW.Big5.po zh_TW.Big5.po.orig
  sed -e 's:\\\\:\\:' zh_TW.Big5.po.orig > zh_TW.Big5.po
}

src_compile() {

  local myopts
  if [ -n "`use gnome`" ]
  then
	myopts="--enable-gnome --enable-panel --prefix=/opt/gnome"
  else
	myopts="--enable-gtkfe --disable-gnome --prefix=/usr/X11R6"
  fi
  if [ "`use ssl`" ] ; then
        myopts="$myopts --enable-openssl"
  fi
  if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
  fi
  try ./configure --host=${CHOST} --disable-perl --disable-python ${myopts}
  try make
}

src_install() {
  cd ${S}
  if [ -n "`use gnome`" ]
  then
  	try make prefix=${D}/opt/gnome install
  else
  	try make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING ChangeLog README
}






