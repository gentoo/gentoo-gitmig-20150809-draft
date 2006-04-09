# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.3.20-r1.ebuild,v 1.2 2006/04/09 04:20:37 halcy0n Exp $

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
SRC_URI="mirror://sourceforge/gnutelephony/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="xml doc ipv6"

DEPEND="xml? ( >=dev-libs/libxml2-2.6.19 )
	doc? ( >=app-doc/doxygen-1.3.6 )"

src_compile() {
	use doc || \
		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure

	econf $(use_with xml) $(use_with ipv6 ) || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS NEWS ChangeLog README \
		THANKS TODO COPYING.addendum

	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml doc/html/*
}

