# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-office/gnome-db/gnome-db-0.2.3.ebuild,v 1.1 2001/04/29 16:17:43 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-db/gnome-db-0.2.91-r1.ebuild,v 1.1 2001/10/06 20:15:36 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Framework for creating database applications"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
	 ftp://ftp.gnome-db.org/pub/gnome-db/sources/${PV}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/gnomedb.shtml"

RDEPEND=">=gnome-base/bonobo-1.0.9-r1
	 >=gnome-extra/libgda-${PV}
	 >=gnome-extra/gal-0.13-r1"

DEPEND="${RDEPEND}
        >=dev-util/xml-i18n-tools-0.8.4"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
        	    --disable-bonobotest

	emake || die
}

src_install() {                               
	make prefix=${D}/usr localedir=${D}/usr/share/local 		\
  	     GNOME_sysconfdir=${D}/etc 					\
	     GNOME_datadir=${D}/usr/share 				\
	     GNOMEDB_oafinfodir=${D}/usr/share/oaf 			\
	     install || die

	dodoc AUTHORS COPYING ChangeLog README
}
