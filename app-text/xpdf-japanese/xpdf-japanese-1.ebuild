# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf-japanese/xpdf-japanese-1.ebuild,v 1.11 2004/10/17 11:11:41 absinthe Exp $

DESCRIPTION="Japanese support for xpdf"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${PN}.tar.gz"
HOMEPAGE="http://www.foolabs.com/xpdf"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc amd64"
IUSE=""
SLOT="0"

DEPEND="app-text/xpdf"

S=${WORKDIR}/${PN}

src_compile() {
	cat /etc/xpdfrc > ${S}/xpdfrc
	sed 's,/usr/local/share/xpdf/,/usr/share/xpdf/,g' ${S}/add-to-xpdfrc >> ${S}/xpdfrc
}

src_install() {
	# don't use builtin make install, as it doesn't compress manpages
	into /usr
	dodoc README
	insinto /etc
	doins xpdfrc
	insinto /usr/share/xpdf/japanese
	doins *.unicodeMap *.cid*
	insinto /usr/share/xpdf/japanese/CMap
	doins CMap/*
}
