# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-db/gnome-db-0.2.93-r1.ebuild,v 1.1 2001/11/04 23:25:11 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Framework for creating database applications"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
		 ftp://ftp.gnome-db.org/pub/gnome-db/sources/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/gnomedb.shtml"

RDEPEND=">=gnome-base/bonobo-1.0.9-r1
		 >=gnome-extra/libgda-${PV}
		 >=gnome-extra/gal-0.13-r1"

DEPEND="${RDEPEND}
		>=dev-util/intltool-0.11"


src_compile() {
	./configure --host=${CHOST} \
				--prefix=/usr \
				--sysconfdir=/etc \
				--localstatedir=/var/lib \
				--disable-bonobotest || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		 sysconfdir=${D}/etc \
		 localstatedir=${D}/var/lib \
		 localedir=${D}/usr/share/local \
		 GNOME_sysconfdir=${D}/etc \
		 GNOME_datadir=${D}/usr/share \
		 GNOMEDB_oafinfodir=${D}/usr/share/oaf \
		 GNOMEDB_oafdir=${D}/usr/share/oaf \
		 install || die
	dodoc AUTHORS COPYING ChangeLog README
}
