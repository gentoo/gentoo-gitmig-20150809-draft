# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commoncpp2/commoncpp2-1.0.9.ebuild,v 1.1 2003/05/10 17:27:16 foser Exp $

IUSE="doc xml2"

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\ 
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="xml2? ( dev-libs/libxml2 )
	doc? ( app-doc/doxygen )"
	
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	local myconf=""

	use xml2 \
		&& myconf="${myconf} --with-xml" \
		|| myconf="${myconf} --without-xml"

	econf ${myconf} || die "./configure failed"

	emake || die

	# kdoc disabled for now, it errors out
	use doc && make doxy
}	

src_install () {

	einstall || die

	dodoc AUTHORS INSTALL NEWS ChangeLog README\
		THANKS TODO COPYING COPYING.addendum
	
	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml docs/html/*
}
