# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-user-manual/gimp-user-manual-2.0.ebuild,v 1.11 2003/02/13 06:35:17 vapier Exp $

S=${WORKDIR}
DESCRIPTION="A user manual for GIMP"
SRC_URI="ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Search.tar.gz
	 ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Color.tar.gz"
HOMEPAGE="http://manual.gimp.org"

DEPEND="sys-apps/tar sys-apps/gzip"
RDEPEND=""

SLOT="0"
LICENSE="OPL"
KEYWORDS="x86 ppc sparc "

src_compile() {
	rm GUM/wwhsrch.js
	touch GUM/wwhsrch.js
}

src_install() {
	 dohtml -r GUM
	 dohtml -r GUMC
	 dodoc README_NOW
}
