# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-3.12.ebuild,v 1.17 2003/09/08 22:01:36 usata Exp $

IUSE=""

DESCRIPTION="TeX macros used by Jade TeX output."
HOMEPAGE="http://jadetex.sourceforge.net/"
SRC_URI="mirror://sourceforge/jadetex/${P}.tar.gz"

KEYWORDS="x86 ppc sparc alpha hppa amd64"
SLOT="0"
LICENSE="freedist"

DEPEND=">=app-text/openjade-1.3.1
	virtual/tetex"

S=${WORKDIR}/${P}

src_compile() {

	addwrite /usr/share/texmf/ls-R
	addwrite /usr/share/texmf/fonts
	addwrite /var/cache/fonts
	emake || die

}

src_install () {

	addwrite /usr/share/texmf/ls-R
	addwrite /usr/share/texmf/fonts
	addwrite /var/cache/fonts
	make \
		DESTDIR=${D} \
		install || die

	dodoc ChangeLog*
	doman *.1

	dodir /usr/bin
	dosym /usr/bin/virtex /usr/bin/jadetex
	dosym /usr/bin/pdfvirtex /usr/bin/pdfjadetex

	dohtml -r doc/*
}

pkg_postinst () {
	mktexlsr
}

pkg_postrm () {
	mktexlsr
}
