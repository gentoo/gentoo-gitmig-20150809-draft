# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-3.12.ebuild,v 1.2 2002/05/27 17:27:36 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TeX macros used by Jade TeX output."
SRC_URI="mirror://sourceforge/jadetex/${P}.tar.gz"
HOMEPAGE="http://jadetex.sourceforge.net/"

DEPEND=">=app-text/openjade-1.3.1
	>=app-text/tetex-1.0.7"


src_compile() {

    emake || die

}

src_install () {

    make \
		DESTDIR=${D} \
		install || die

    dodoc ChangeLog*
    doman *.1
	
	dodir /usr/bin
    dosym /usr/bin/virtex /usr/bin/jadetex
    dosym /usr/bin/pdfvirtex /usr/bin/pdfjadetex
	
	dohtml -r doc

}

pkg_postinst () {
    mktexlsr
}
