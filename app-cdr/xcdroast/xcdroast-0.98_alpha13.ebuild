# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha13.ebuild,v 1.1 2003/01/04 12:40:17 agenkin Exp $

DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
HOMEPAGE="http://www.xcdroast.org/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	>=media-libs/giflib-3.0
	>=app-cdr/cdrtools-2.0"

SLOT="0"
S=${WORKDIR}/${P/_/}
SRC_URI="mirror://sourceforge/xcdroast/${P/_/}.tar.gz"

src_compile() {
	./configure --prefix=/usr
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} install || die
	#chown root.wheel ${D}/usr/bin/xcdrgtk
	cd doc
	dodoc DOCUMENTATION FAQ README* TRANSLATION.HOWTO
	cd ..

	# move man pages to /usr/share/man to be LFH compliant
	mv ${D}/usr/man ${D}/usr/share

	#remove extraneous directory
	rm ${D}/usr/etc -rf
}
