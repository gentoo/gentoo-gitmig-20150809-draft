# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com> 
# /home/cvsroot/gentoo-x86/app-cdr/cdrx/cdrx-0.2.ebuild,v 1.1 2001/06/04 19:37:29 blutgens Exp

A=xcdroast-0.98alpha8.tar.gz
S=${WORKDIR}/xcdroast-0.98alpha8
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://www.xcdroast.org/download/${A}"
HOMEPAGE="http://www.xcdroast.org/"

DEPEND=">=app-cdr/cdrecord-1.9
	>=dev-libs/glib-1.2.3
	>=x11-libs/gtk+-1.2.3
	>=media-libs/giflib-3.0"


src_compile () {
	try make ${MAKEOPTS} CC=\"gcc $CFLAGS\"

}

src_install () {

	try make DESTDIR=${D} install
        chown root.wheel ${D}/usr/bin/xcdrgtk
        dodoc CHANGELOG COPYING DOCUMENTATION FAQ README* TRANSLATION.HOWTO
}

