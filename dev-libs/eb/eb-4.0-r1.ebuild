# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eb/eb-4.0-r1.ebuild,v 1.7 2005/03/19 11:24:10 matsuu Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="EB is a C library and utilities for accessing CD-ROM books"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/eb/"
SRC_URI="ftp://ftp.sra.co.jp/pub/misc/eb/${P}.tar.gz
	ftp://ftp.sra.co.jp/pub/misc/eb/${P}+.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/libc
	sys-libs/zlib
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}+.diff
}

src_compile () {

	econf `use_enable nls` || die
	emake || die
}

src_install () {

	einstall || die

	dodoc AUTHORS INSTALL* NEWS README*
}
