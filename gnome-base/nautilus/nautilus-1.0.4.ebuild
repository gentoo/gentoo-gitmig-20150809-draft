## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated by Sebastian Werner <sebastian@werner-productions.de>
# /home/cvsroot/gentoo-x86/gnome-apps/nautilus/nautilus-1.0.ebuild,v 1.3 2001/04/29 18:42:54 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-1.0.4.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="nautilus"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
	 ftp://rpmfind.net/linux/gnome.org/stable/latest/sources/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
	mozilla? ( >=net-www/mozilla-0.8-r1 )
        >=media-sound/cdparanoia-3.9.8
        >=gnome-base/bonobo-1.0.2
        >=gnome-base/libghttp-1.0.9
        >=gnome-base/scrollkeeper-0.2
	>=gnome-base/gnome-core-1.4.0.4
	>=gnome-libs/medusa-0.5.1
	>=gnome-libs/eel-1.0
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND="mozilla? ( >=net-www/mozilla-0.8-r1 )
        >=media-sound/cdparanoia-3.9.8
        >=gnome-base/bonobo-1.0.2
        >=gnome-base/gnome-core-1.4.0.4
	>=gnome-libs/medusa-0.5.1
	>=gnome-libs/eel-1.0"

src_compile() {                           
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  if [ "`use mozilla`" ]
  then
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
        --sysconfdir=/etc/opt/gnome --infodir=/opt/gnome/info \
	--mandir=/opt/gnome/man --enable-eazel-services=1 ${myconf}
  try pmake
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
        mandir=${D}/opt/gnome/man infodir=${D}/opt/gnome/info install
  dodoc AUTHORS COPYING* ChangeLog* NEWS TODO
}





