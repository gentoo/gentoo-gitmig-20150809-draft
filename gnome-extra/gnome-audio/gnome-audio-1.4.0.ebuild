# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-1.4.0.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


P=gnome-audio-1.4.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-audio"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-audio/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND="gnome-base/gnome-env"


src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc README
}



