# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eb/eb-4.0.ebuild,v 1.1 2004/01/01 20:21:05 usata Exp $

IUSE="nls"

DESCRIPTION="EB a C library and utilities for accessing CD-ROM books"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/eb/"
SRC_URI="ftp://ftp.sra.co.jp/pub/misc/eb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	sys-libs/zlib
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}

src_compile () {

	econf `use_enable nls` || die
	emake || die
}

src_install () {

	einstall || die

	dodoc AUTHORS INSTALL* NEWS README*
}
