# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha9.ebuild,v 1.3 2001/11/10 02:36:21 hallski Exp $


S=${WORKDIR}/xcdroast-0.98alpha9
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://www.xcdroast.org/download/${PN}-0.98alpha9.tar.gz"
HOMEPAGE="http://www.xcdroast.org/"

DEPEND=">=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1
	>=media-libs/giflib-3.0"

RDEPEND=">=app-cdr/cdrtools-1.11"

src_compile () {
	make PREFIX=/usr CC="gcc ${CFLAGS}" || die
}

src_install () {
	
	make PREFIX=/usr DESTDIR=${D} install || die
        chown root.wheel ${D}/usr/bin/xcdrgtk
        dodoc CHANGELOG COPYING DOCUMENTATION FAQ README* TRANSLATION.HOWTO
}

