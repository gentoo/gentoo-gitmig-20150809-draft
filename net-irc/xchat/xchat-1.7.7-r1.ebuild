# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.7.7-r1.ebuild,v 1.1 2001/06/17 23:19:16 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.7/"${A}
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=gnome-base/gdk-pixbuf-0.11.0 
        perl? ( sys-devel/perl )
	python? ( dev-lang/python )
	nls? ( >=sys-devel/gettext-0.10.38 )
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
        ssl? ( >=dev-libs/openssl-0.9.6a )"

RDEPEND=">=gnome-base/gdk-pixbuf-0.11.0
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 ) ssl? ( >=dev-libs/openssl-0.9.6a )"

src_compile() {

  local myopts
  local myflags

  if [ "`use gnome`" ]
  then
	myopts="--enable-gnome --enable-panel --prefix=/opt/gnome"
  else
	myopts="--enable-gtkfe --disable-gnome --prefix=/usr/X11R6"
  fi
  if [ "`use ssl`" ] ; then
        myopts="$myopts --enable-openssl"
  fi 
  if [ -z "`use perl`" ] ; then
        myopts="$myopts --disable-perl"
  fi
  if [ "`use python`" ] ; then
    myflags="-lz"
    if [ "`use berkdb`" ] ; then
	myflags="$myflags -ldb-3.2 -lndbm"
    fi
    if [ "`use readline`" ] ; then
	myflags="$myflags -lreadline -lncurses -lcrypt"
    fi
  else
	myopts="$myopts --disable-python"
  fi 
  if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
  fi
  try ./configure --host=${CHOST} ${myopts}
  if [ "$myflags" ] ; then
    for i in src/fe-gtk src/fe-text
    do
      if [ -e $i/Makefile ] ; then
        cp  $i/Makefile $i/Makefile.orig
        sed -e "s:-lpython2.0:-lpython2.0 $myflags:" \
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






