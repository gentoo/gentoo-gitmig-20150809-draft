# Distributed under the terms of the GNU General Public License, v2 or later
# A Gnome ICQ Clone
# Author Ben Lutgens <blutgens@gentoo.org>

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="http://download.sourceforge.net/gnomeicu/${A}"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.0
	>=gnome-base/gnome-core-1.2.4"

src_unpack() {
  unpack ${A}
  cd ${S}/src
  cp ${FILESDIR}/userserver.patch .
  patch -p0 < userserver.patch
}

src_compile() {                           
  

  local myconf
  local myprefix
  myprefix="/opt/gnome"
  if [ -z "`use esd`" ]
  then
  	myconf="--disable-esd-test"
  fi
  if [ "`use socks5`" ];
  then
  	myconf="${myconf} --enable-socks5"
  fi

# This is busted, I'm not sure if it's my box or what, I don't have nls in use
# so the disabling should work perfectly.
#
#  if [ -z "`use nls`" ]
#  then
#	myconf="${myconf} --disable-nls"
#  fi
  try ./configure --host=${CHOST} ${myconf} --prefix=${myprefix}
  try make
}

src_install() {

  try make DESTDIR=${D}  install
  dodoc AUTHORS COPYING CREDITS ChangeLog INSTALL NEWS README TODO ABOUT-NLS
}
