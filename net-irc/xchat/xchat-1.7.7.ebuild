# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="gtk/gnome irc client"
SRC_URI="http://www.xchat.org/files/source/1.7/"${A}
HOMEPAGE="http://www.xchat.org/"

DEPEND=">=x11-libs/gtk+-1.2.10
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
	gnome? ( >=gnome-base/gdk-pixbuf-0.11.0 )
	nls? ( >=sys-devel/gettext-0.10.38 )
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )"
#	ssl? ( >=dev-libs/openssl-0.9.6a )"
	python? ( >=dev-lang/python-2.0 )" 
# ssl does not seem to work... feel free to try it if you'd like =)	

src_compile() {
e
  local myopts
  if [ -n "`use gnome`" ]
  then
	myopts="--enable-gnome --enable-panel --prefix=/opt/gnome"
  else
	myopts="--enable-gtkfe --disable-gnome --prefix=/usr/X11R6"
  fi
#  if [ "`use ssl`" ]
#  then
#	myopts="$myopts --enable-openssl"
#  else
#	myopts="$myopts --disable-openssl"
#  fi
   if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
  fi
  if [ "`use python`" ]
  then
	myopts="$myopts --enable-python"
  else
	myopts="$myopts --disable-python"
  fi
  if [ -z "`use perl`" ] ; then
  	myopts="$myopts --disable-perl"
  fi
  try ./configure --host=${CHOST} ${myopts} --disable-openssl
  #try ./configure --host=${CHOST} ${myopts}
  try pmake
}

src_install() {
  
  if [ -n "`use gnome`" ]
  then
  	try make prefix=${D}/opt/gnome install
  else
  	try make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING ChangeLog README
}
