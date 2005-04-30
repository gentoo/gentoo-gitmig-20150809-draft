# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.9.2-r1.ebuild,v 1.1 2005/04/30 03:22:28 flameeyes Exp $

DESCRIPTION="GNU charset conversion library for libc which doesn't implement it"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64 -x86-fbsd"
IUSE="nls"

RDEPEND="virtual/libc
	!sys-libs/glibc"
DEPEND="${RDEPEND}
	app-admin/chrpath"

src_compile() {
	econf \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Temporary fix for rpath removing
	chrpath -d ${D}/usr/bin/iconv || die

	dodoc ABOUT-NLS DESIGN NEWS NOTES PORTS README* THANKS ChangeLog
}

