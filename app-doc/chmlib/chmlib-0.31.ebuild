# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/chmlib/chmlib-0.31.ebuild,v 1.2 2003/09/10 16:04:27 mholzer Exp $

DESCRIPTION="Library for MS CHM (compressed html) file format plus extracting and http server utils"
HOMEPAGE="http://66.93.236.84/~jedwin/projects/chmlib/"
SRC_URI="http://66.93.236.84/~jedwin/projects/chmlib/${PF}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:gcc-3.2:gcc:" Makefile
	sed -i "s:/usr/local/:/${D}/usr/:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	#Make expects to find these dirs.
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/include
	dodir /usr/share/doc/${PF}/examples/

	make install

	#Build additional utils, making this lib useful by itself.
	#This cannot be build in src_compile as it needs to find chmlib.
	emake extract_chmLib || die
	emake chm_http || die
	exeinto /usr/bin
	newexe extract_chmLib chmextract
	newexe chm_http chmhttp

	#Install examples as well.
	insinto /usr/share/doc/${PF}/examples/
	doins test_chmLib.c enum_chmLib.c chm_http.c

	dodoc AUTHORS COPYING NEWS README
}
