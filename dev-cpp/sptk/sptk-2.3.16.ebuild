# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-2.3.16.ebuild,v 1.1 2004/11/28 21:44:09 iluxa Exp $

IUSE="fltk odbc"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://sptk.tts-sf.com/sptk-${PV}.tbz2"
HOMEPAGE="http://sptk.tts-sf.com"

SLOT="2"
LICENSE="|| ( FLTK GPL-2 )"
KEYWORDS="~x86 ~sparc ~mips"

DEPEND="fltk? ( x11-libs/fltk )
	odbc? ( >=dev-db/unixODBC-2.2.6 )"

src_compile() {

	local myconf
	myconf="--enable-shared"

	use odbc || myconf="${myconf} --disable-odbc" #default enabled
	use fltk || myconf="${myconf} --disable-fltk"

	econf \
		--prefix=/usr \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {

	einstall \
		includedir=${D}/usr/include/sptk \
		libdir=${D}/usr/lib || die "Installation Failed"

	dodoc CHANGES COPYING README

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/sptk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/sptk
}
