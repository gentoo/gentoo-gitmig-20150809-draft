# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-user-manual/gimp-user-manual-2.0.ebuild,v 1.8 2002/10/04 04:01:57 vapier Exp $

S=${WORKDIR}
DESCRIPTION="A user manual for GIMP"
SRC_URI="ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Search.tar.gz
	 ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Color.tar.gz"
HOMEPAGE="http://manual.gimp.org"
DEPEND=""

SLOT="0"
LICENSE="OPL"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	rm GUM/wwhsrch.js
	touch GUM/wwhsrch.js

}

src_install () {
	 dohtml -r GUM
	 dohtml -r GUMC
	 dodoc README_NOW
}
