## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated by Sebastian Werner <sebastian@werner-productions.de>
# /home/cvsroot/gentoo-x86/gnome-apps/nautilus/nautilus-1.0.ebuild,v 1.3 2001/04/29 18:42:54 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="nautilus"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
	mozilla? ( >=net-www/mozilla-0.8-r1 )
        >=media-libs/freetype-2.0.1
        >=sys-libs/pam-0.73
	>=gnome-base/bonobo-1.0.2
	>=gnome-base/libghttp-1.0.9
        >=gnome-base/scrollkeeper-0.2
	>=gnome-base/control-center-1.4.0
	>=gnome-libs/medusa-0.5.1
        >=gnome-libs/ammonite-1.0.2
	>=gnome-libs/librsvg-1.0.0"

src_compile() {                           
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  if [ "`use mozilla`" ]
  then
#    MOZILLA=${S}/../../../mozilla-0.8-r2/work/mozilla/dist
    MOZILLA=/opt/mozilla
    myconf="${myconf} --with-mozilla-lib-place=$MOZILLA \
		--with-mozilla-include-place=$MOZILLA/include"
    export MOZILLA_FIVE_HOME=$MOZILLA
    export LD_LIBRARY_PATH=$MOZILLA_FIVE_HOME
#    export CXXFLAGS="$CXXFLAGS -fno-exceptions -fno-rtti"
  else
    myconf="${myconf} --disable-mozilla-component"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
        --sysconfdir=/etc/opt/gnome --infodir=/opt/gnome/share/info \
	--mandir=/opt/gnome/share/man --enable-eazel-services=1 ${myconf}
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
        mandir=${D}/opt/gnome/share/man infodir=${D}/opt/gnome/share/info install
  dodoc AUTHORS COPYING* ChangeLog* NEWS TODO
}





