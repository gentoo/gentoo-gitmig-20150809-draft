# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commoncpp2/commoncpp2-1.0.1.ebuild,v 1.2 2002/10/04 20:34:09 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\ 
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="sys-libs/zlib
	xml2? ( dev-libs/libxml2 )
	doc? ( app-doc/doxygen )"
	
RDEPEND=${DEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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
	
	# the docs come out already compressed
	use doc && ( \
		dodoc commoncpp2-html-manual-1.0.1.tar.gz \
			commoncpp2-latex-manual-1.0.1.tar.gz
	) 
}
