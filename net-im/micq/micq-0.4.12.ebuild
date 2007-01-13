# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.12.ebuild,v 1.8 2007/01/13 18:24:56 tester Exp $

IUSE="tcl ssl"

SRC_URI="http://www.micq.org/source/${P}.tgz"
DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.micq.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 alpha sparc ~ppc amd64"
DEPEND="virtual/libc
	ssl? ( >=net-libs/gnutls-0.8.10
		dev-libs/openssl )
	tcl? ( dev-lang/tcl )"

src_compile() {
	econf \
		$(use_enable tcl) \
		$(use_enable ssl) \
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
