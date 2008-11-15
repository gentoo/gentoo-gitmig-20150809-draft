# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-2.3.28.ebuild,v 1.6 2008/11/15 12:09:14 coldwind Exp $

EAPI=1

IUSE="fltk odbc"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://sptk.tts-sf.com/sptk-${PV}.tbz2"
HOMEPAGE="http://sptk.tts-sf.com"

SLOT="2"
LICENSE="|| ( FLTK GPL-2 )"
KEYWORDS="x86 ~sparc ~mips ~amd64 ~ppc"

DEPEND="fltk? ( x11-libs/fltk:1.1 )
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
		includedir="${D}"/usr/include/sptk \
		libdir="${D}"/usr/lib || die "Installation Failed"

	dodoc CHANGES README

	dodir /usr/share/doc/"${PF}"/html
	mv "${D}"/usr/share/doc/sptk/* "${D}"/usr/share/doc/"${PF}"/html
	rmdir "${D}"/usr/share/doc/sptk
}
