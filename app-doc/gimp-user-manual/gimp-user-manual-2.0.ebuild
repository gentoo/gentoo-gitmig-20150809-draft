# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-user-manual/gimp-user-manual-2.0.ebuild,v 1.6 2002/08/01 14:02:43 seemant Exp $

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
