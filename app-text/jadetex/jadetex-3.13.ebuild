# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-3.13.ebuild,v 1.2 2004/09/22 00:27:01 vapier Exp $

DESCRIPTION="TeX macros used by Jade TeX output"
HOMEPAGE="http://jadetex.sourceforge.net/"
SRC_URI="mirror://sourceforge/jadetex/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~arm ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=app-text/openjade-1.3.1
	virtual/tetex"

src_compile() {
	addwrite /usr/share/texmf/ls-R
	addwrite /usr/share/texmf/fonts
	addwrite /var/cache/fonts
	emake || die
}

src_install() {
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
