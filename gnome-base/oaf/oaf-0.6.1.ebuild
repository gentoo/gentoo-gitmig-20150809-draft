# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.1.ebuild,v 1.2 2000/12/03 20:46:29 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Object Activation Framework for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/"${A}

DEPEND=">=app-arch/rpm-3.0.5
	>=gnome-base/ORBit-0.5.4
	>=gnome-base/libxml-1.8.10"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}

pkg_postinst() {
	ldconfig -r ${ROOT}
}



