# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.51.1-r1.ebuild,v 1.2 2004/02/01 23:02:47 tantive Exp $
S=${WORKDIR}/${P}
DESCRIPTION="iODBC is the acronym for Independent Open DataBase Connectivity, an Open Source platform independent implementation of both the ODBC and X/Open specifications. It is rapidly emerging as the industry standard for developing solutions that are language, platform and database independent."
SRC_URI="http://www.iodbc.org/dist/libiodbc-${PV}.tar.gz"
HOMEPAGE="http://www.iodbc.org"
LICENSE="LGPL-2 BSD"
DEPEND="gtk? ( =x11-libs/gtk+-1* )"
IUSE="gtk"
KEYWORDS="~x86"
SLOT=0

src_compile() {
	local myconf
	myconf="--prefix=${D}/usr/local --exec-prefix=${D}/usr/local --with-iodbc-inidir=/etc"
	use gtk || myconf="$myconf --disable-gui --disable-gtktest"
	econf ${myconf}
	emake
}

src_install () {
	make install || die "make install failed"
	## need to fix *.la
	cd ${D}/usr/local/lib
	for file in `ls *.la`; do
	sed -i "s:"${D}"/usr/local:/usr/local:" $file;
	done
}
