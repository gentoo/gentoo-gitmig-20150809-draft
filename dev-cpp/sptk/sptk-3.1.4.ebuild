# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sptk/sptk-3.1.4.ebuild,v 1.1 2006/05/29 10:28:04 iluxa Exp $

inherit autotools

IUSE="fltk odbc doc sqlite3"

DESCRIPTION="C++ user interface toolkit for X with database and Excel support"
SRC_URI="http://www.sptk.net/sptk-${PV}.tbz2"
HOMEPAGE="http://www.sptk.net"

SLOT="3"
LICENSE="|| ( FLTK GPL-2 )"
KEYWORDS="~x86 ~sparc ~mips ~amd64 ~ppc"

DEPEND="fltk? ( x11-libs/fltk )
	odbc? ( >=dev-db/unixODBC-2.2.6 )
	sqlite3? ( >=dev-db/sqlite-3 )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# This fixes double ./configure run
	eautoreconf
}

src_compile() {

	local myconf
	myconf="--enable-shared"

	econf \
		--prefix=/usr \
		`use_enable odbc` \
		`use_enable fltk` \
		`use_enable sqlite3` \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"

	if use doc; then
		cd "${S}"
		einfo "Fixing sptk3.doxygen"
		sed -i -e 's,/cvs/sptk3/,,g' sptk3.doxygen
		einfo "Building docs"
		doxygen sptk3.doxygen
	fi

}

src_install () {

	make DESTDIR=${D} install || die "Installation failed"

	dodoc README AUTHORS

	dodir /usr/share/doc/${PF}
	cp -r ${S}/docs/* ${D}/usr/share/doc/${PF}
	if use doc; then
		rm -fr ${D}/usr/share/doc/${PF}/latex
		cp -r ${S}/pictures ${D}/usr/share/doc/${PF}
	fi
}
