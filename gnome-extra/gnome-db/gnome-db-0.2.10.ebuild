# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-office/gnome-db/gnome-db-0.2.3.ebuild,v 1.1 2001/04/29 16:17:43 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-db/gnome-db-0.2.10.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Framework for creating database applications"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
	 ftp://ftp.gnome-db.org/pub/gnome-db/sources/${PV}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/gnomedb.shtml"

DEPEND=">=gnome-base/bonobo-0.30
	>=gnome-libs/libgda-0.2.10
        >=gnome-base/gal-0.8
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=gnome-base/bonobo-0.30
	>=gnome-libs/libgda-0.2.10"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
        --datadir=/opt/gnome/share --disable-bonobotest
  try pmake
}

src_install() {                               
  try make prefix=${D}/opt/gnome localedir=${D}/opt/gnome/share/local \
	GNOME_sysconfdir=${D}/opt/gnome/etc \
	GNOME_datadir=${D}/opt/gnome/share \
	GNOMEDB_oafinfodir=${D}/opt/gnome/share/oaf \
	install
  dodoc AUTHORS COPYING ChangeLog README
}



