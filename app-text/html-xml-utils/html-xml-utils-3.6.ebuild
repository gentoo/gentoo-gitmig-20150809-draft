# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-3.6.ebuild,v 1.5 2006/03/16 14:39:39 ehmsen Exp $

inherit eutils

DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
LICENSE="W3C"

IUSE=""
KEYWORDS="~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Replace references to normalize with normalize-html, which
	# has been renamed due to clash described in #27399
	sed -i "s:normalize:&-html:g" *.1 || die "sed failed"

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO

	# Check bug #27399, the following binary conflicts with
	# one provided by the 'normalize' package, so we're
	# renaming this one <obz@gentoo.org>
	mv ${D}/usr/bin/normalize ${D}/usr/bin/normalize-html
	mv ${D}/usr/share/man/man1/normalize.1 \
	   ${D}/usr/share/man/man1/normalize-html.1

}
