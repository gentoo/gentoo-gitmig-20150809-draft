# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.10.4.ebuild,v 1.1 2003/10/01 14:16:25 usata Exp $

IUSE="tcl ssl"

SRC_URI="ftp://www.micq.org/pub/micq/source/${P}.tgz
	http://www.micq.org/source/${P}.tgz"
DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.micq.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE=""
DEPEND="virtual/glibc"

src_compile() {

	econf `use_enable tcl` \
		`use_enable ssl` \
		|| die "econf failed"
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
