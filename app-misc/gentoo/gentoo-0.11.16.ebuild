# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.16.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A gnome based filemanager"
SRC_URI="http://www.obsession.se/gentoo/${A}"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND=">=gnome-base/gnome-core-1.2.0"

src_compile() {
  cd src
  cp Makefile Makefile.orig
  sed -e "s:= /usr/local:= /opt/gnome:g" \
      -e "s:ICONS:ICONS= /opt/gnome/share/gentoo #:g" \
      -e 's:${prefix}/etc:/etc/opt/gnome/gentoo:g' \
      -e 's:${exec_prefix}/lib/gentoo/icons:${exec_prefix}/share/gentoo/icons:g' Makefile.orig > Makefile
  rm Makefile.orig
  cd ..
  try make
}

src_install() {
  cd src
  into /opt/gnome
  dobin gentoo
  cd ..
  dodir /opt/gnome/share
  dodir /opt/gnome/share/gentoo
  # Maybe fixed later
  cp -a icons ${D}/opt/gnome/share/gentoo
  chmod 755 ${D}/opt/gnome/share/gentoo/icons

  insinto /etc/opt/gnome/gentoo
  doins gentoorc-example

  dodoc COPYING README TODO
}




