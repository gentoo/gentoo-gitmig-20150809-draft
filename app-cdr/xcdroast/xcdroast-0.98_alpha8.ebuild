# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@sistina.com> 
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha8.ebuild,v 1.6 2001/08/31 03:23:38 pm Exp $


A=xcdroast-0.98alpha8.tar.gz
S=${WORKDIR}/xcdroast-0.98alpha8
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://www.xcdroast.org/download/${A}"
HOMEPAGE="http://www.xcdroast.org/"

DEPEND=">=dev-libs/glib-1.2.3
	>=x11-libs/gtk+-1.2.3
	>=media-libs/imlib-1.8
	>=media-libs/giflib-3.0"

RDEPEND=">=app-cdr/cdrecord-1.9"

src_compile () {
	try env "CC='gcc ${CFLAGS}'"
	try make ${MAKEOPTS}

}

src_install () {

	try make DESTDIR=${D} install
        chown root.wheel ${D}/usr/bin/xcdrgtk
        dodoc CHANGELOG COPYING DOCUMENTATION FAQ README* TRANSLATION.HOWTO
}

