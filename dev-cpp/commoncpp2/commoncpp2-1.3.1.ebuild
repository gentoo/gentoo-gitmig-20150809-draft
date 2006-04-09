# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.3.1.ebuild,v 1.3 2006/04/09 04:20:37 halcy0n Exp $

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
SRC_URI="mirror://sourceforge/cplusplus/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc xml"

DEPEND="xml? ( >=dev-libs/libxml2-2.6.19 )"

src_compile() {
	econf $(use_with xml) || die "./configure failed"

	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS INSTALL NEWS ChangeLog README\
		THANKS TODO COPYING COPYING.addendum

	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml doc/html/*
}
