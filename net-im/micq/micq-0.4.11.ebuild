# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.11.ebuild,v 1.3 2004/03/27 16:20:36 usata Exp $

IUSE="tcltk ssl"

SRC_URI="ftp://www.micq.org/pub/micq/source/${P}.tgz
	http://www.micq.org/source/${P}.tgz"
DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.micq.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 alpha ~sparc"
DEPEND="virtual/glibc
	ssl? ( >=net-libs/gnutls-0.8.10
		dev-libs/openssl )"

src_compile() {

	econf `use_enable tcltk tcl` \
		`use_enable ssl` \
		|| die "econf failed"
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
