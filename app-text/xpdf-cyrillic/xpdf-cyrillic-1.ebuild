# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf-cyrillic/xpdf-cyrillic-1.ebuild,v 1.7 2004/10/17 11:10:18 absinthe Exp $

DESCRIPTION="Cyrillic support for xpdf"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${PN}.tar.gz"
HOMEPAGE="http://www.foolabs.com/xpdf"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""
SLOT="0"

DEPEND="app-text/xpdf"

S=${WORKDIR}/${PN}

src_compile() {
	cat /etc/xpdfrc > ${S}/xpdfrc
	sed 's,/usr/local/share/xpdf/,/usr/share/xpdf/,g' ${S}/add-to-xpdfrc >> ${S}/xpdfrc
}

src_install() {
	into /usr
	dodoc README
	insinto /etc
	doins xpdfrc
	insinto /usr/share/xpdf/cyrillic
	doins KOI8-R.unicodeMap
}
