# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eb/eb-4.2.2.ebuild,v 1.12 2007/08/13 20:22:11 dertobi123 Exp $

inherit eutils

IUSE="nls ipv6 threads"

DESCRIPTION="EB is a C library and utilities for accessing CD-ROM books"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/eb/"
SRC_URI="ftp://ftp.sra.co.jp/pub/misc/eb/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc x86"

DEPEND="virtual/libc
	sys-libs/zlib
	nls? ( sys-devel/gettext )"

src_compile () {
	econf \
		--with-pkgdocdir=/usr/share/doc/${PF}/html \
		`use_enable nls` \
		`use_enable threads pthread` \
		`use_enable ipv6` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL* NEWS README*
}

pkg_postinst() {
	elog
	elog "If you are upgrading from <app-dicts/eb-4,"
	elog "you may need to rebuild applications depending on eb."
	elog
}
