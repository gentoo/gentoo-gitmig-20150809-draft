# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/poslib/poslib-1.0.5.ebuild,v 1.1 2004/08/09 23:11:30 matsuu Exp $

inherit flag-o-matic

DESCRIPTION="A library for creating C++ programs using the Domain Name System"
HOMEPAGE="http://www.posadis.org/projects/poslib.php"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	append-flags -funsigned-char

	econf \
		--with-cxxflags="${CXXFLAGS}" \
		`use_enable ipv6` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
