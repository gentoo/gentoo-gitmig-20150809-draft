# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.4.ebuild,v 1.2 2001/08/23 10:08:55 hallski Exp $

P=GConf-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/GConf/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=sys-libs/db-3.2.3h
	>=gnome-base/gnome-env-1.0
        >=gnome-base/oaf-0.6.5
	>=gnome-base/gnome-libs-1.2.10
        >=dev-util/guile-1.4"

RDEPEND=">=sys-libs/db-3.2.3h
	>=gnome-base/gnome-env-1.0
        >=gnome-base/oaf-0.6.5
	>=gnome-base/gnome-libs-1.2.10"

#src_unpack() {
#  unpack ${A}
  # for some reason, the GConf package doesn't come w/ an intl directory,
  # so I copied it from another package, and made a diff
#  cd ${S}
#  try patch -p1 < ${FILESDIR}/${PF}-gentoo-intl.diff
#}

src_compile() {

  local myconf

  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi

  ./configure --host=${CHOST} --prefix=/opt/gnome  --sysconfdir=/etc/opt/gnome ${myconf} || die

  make || die   # Doesn't work with -j 4 (hallski)
}

src_install() {

  make DESTDIR=${D} install || die
  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO

}





