# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/shash/shash-0.2.6.ebuild,v 1.1 2004/01/21 06:45:10 robbat2 Exp $

DESCRIPTION="Generate or check digests or MACs of files"
HOMEPAGE="http://mcrypt.hellug.gr/${PN}/"
SRC_URI="ftp://mcrypt.hellug.gr/pub/mcrypt/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static"
DEPEND="virtual/glibc
		>=app-crypt/mhash-0.8.18-r1"

src_compile() {
	econf `use_enable static static-link` || die "econf failed"
	emake || die "emake failed"
}
src_install() {
	make install DESTDIR=${D} || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS doc/sample.shashrc doc/FORMAT
}
