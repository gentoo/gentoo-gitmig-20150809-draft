# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-3.12.ebuild,v 1.16 2003/09/05 22:37:22 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TeX macros used by Jade TeX output."
SRC_URI="mirror://sourceforge/jadetex/${P}.tar.gz"
HOMEPAGE="http://jadetex.sourceforge.net/"
SLOT="0"
LICENSE="freedist"

DEPEND=">=app-text/openjade-1.3.1
	>=app-text/tetex-1.0.7"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

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

	dohtml -r doc

}

pkg_postinst () {
	mktexlsr
}
