# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netleds_applet/netleds_applet-0.9.1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gnome applet that displays leds from network load"
SRC_URI="http://netleds.port5.com/${P}.tar.gz"
HOMEPAGE="http://netleds.port5.com/"

DEPEND=">=gnome-base/gnome-core-1.2.0
	>=gnome-base/libgtop-1.0.12"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome --enable-shared
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}




