# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.16-r1.ebuild,v 1.1 2001/10/07 15:02:08 azarah Exp $


S=${WORKDIR}/${P}
DESCRIPTION="A gnome based filemanager"
SRC_URI="http://www.obsession.se/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4-r1"

src_compile() {
  cd src
  cp Makefile Makefile.orig
  sed -e "s:= /usr/local:= /usr:g" \
      -e "s:ICONS:ICONS= /usr/share/gentoo #:g" \
      -e 's:${prefix}/etc:/etc/gnome/gentoo:g' \
      -e 's:${exec_prefix}/lib/gentoo/icons:${exec_prefix}/share/gentoo/icons:g' Makefile.orig > Makefile
  rm Makefile.orig
  cd ..
  try make
}

src_install() {
  cd src
  into /usr
  dobin gentoo
  cd ..
  dodir /usr/share
  dodir /usr/share/gentoo
  # Maybe fixed later
  cp -a icons ${D}/usr/share/gentoo
  chmod 755 ${D}/usr/share/gentoo/icons

  insinto /etc/gnome/gentoo
  doins gentoorc-example

  dodoc COPYING README TODO
}




