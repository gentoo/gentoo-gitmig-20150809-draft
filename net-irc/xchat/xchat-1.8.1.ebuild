# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.8.1.ebuild,v 1.2 2001/07/29 10:53:03 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.8/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=media-libs/gdk-pixbuf-0.11
        perl? ( sys-devel/perl )
        python? ( >=dev-lang/python-2.0-r4 )
        nls? ( >=sys-devel/gettext-0.10.38 )
        gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
        ssl? ( >=dev-libs/openssl-0.9.6a )"

RDEPEND=">=media-libs/gdk-pixbuf-0.11
         gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
         ssl? ( >=dev-libs/openssl-0.9.6a )"

src_compile() {

  local myopts
  local myflags

  if [ "`use gnome`" ]
  then
	myopts="--enable-gnome --enable-panel --prefix=/opt/gnome"
  else
	myopts="--enable-gtkfe --disable-gnome --prefix=/usr/X11R6 --disable-gdk-pixbuf"
  fi
  if [ "`use ssl`" ] ; then
        myopts="$myopts --enable-openssl"
  fi 
  if [ -z "`use perl`" ] ; then
        myopts="$myopts --disable-perl"
  fi
  if [ "`use python`" ] ; then
    myflags="`python-config --libs`"
  else
	myopts="$myopts --disable-python"
  fi 
  if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
  fi
  try ./configure --host=${CHOST} ${myopts} --enable-ipv6
  if [ "$myflags" ] ; then
    for i in src/fe-gtk src/fe-text
    do
      if [ -e $i/Makefile ] ; then
        cp  $i/Makefile $i/Makefile.orig
        sed -e "s:-lpython2.0:$myflags:" \
	  $i/Makefile.orig > $i/Makefile
      fi
    done
  fi
  try pmake
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






