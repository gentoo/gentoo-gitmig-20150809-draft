# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-db/gnome-db-0.2.1.ebuild,v 1.1 2000/12/21 08:22:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Framework for creating database applications"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/gnomedb.shtml"

DEPEND=">=gnome-base/gtkhtml-0.7
	>=gnome-base/bonobo-0.28
	>=gnome-libs/libgda-0.2.0"

src_compile() {                           
  cd ${S}

  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-mysql=/usr --with-ldap=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome \
	GNOME_sysconfdir=${D}/opt/gnome/etc \
	GNOME_datadir=${D}/opt/gnome/share \
	GNOMEDB_oafinfodir=${D}/opt/gnome/share/oaf \
	install
  dodoc AUTHORS COPYING ChangeLog README
}



