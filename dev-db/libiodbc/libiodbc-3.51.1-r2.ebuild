# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.51.1-r2.ebuild,v 1.1 2004/02/02 01:29:25 robbat2 Exp $
DESCRIPTION="iODBC is the acronym for Independent Open DataBase Connectivity, an Open Source platform independent implementation of both the ODBC and X/Open specifications. It is rapidly emerging as the industry standard for developing solutions that are language, platform and database independent."
SRC_URI="http://www.iodbc.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.iodbc.org/"
LICENSE="LGPL-2 BSD"
DEPEND="gtk? ( =x11-libs/gtk+-1* )"
IUSE="gtk"
KEYWORDS="~x86"
SLOT=0

src_compile() {
	local myconf
	use gtk || myconf="${myconf} --disable-gui --disable-gtktest"
	econf ${myconf} --with-iodbc-inidir=/etc 
	emake
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog IAFA-PACKAGE LICENSE* README* NEWS
	# these files conflict with unixODBC
	#rm ${D}/usr/include/sql*
}
