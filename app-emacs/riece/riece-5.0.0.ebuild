# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/riece/riece-5.0.0.ebuild,v 1.5 2008/08/24 11:58:39 corsair Exp $

inherit elisp

DESCRIPTION="A redesign of Liece IRC client"
HOMEPAGE="http://www.nongnu.org/riece/"
SRC_URI="http://savannah.nongnu.org/download/riece/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="linguas_ja"
RESTRICT="test"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf --with-lispdir="${SITELISP}" || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall lispdir="${D}/${SITELISP}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc AUTHORS NEWS README doc/HACKING lisp/ChangeLog* || die "dodoc failed"

	if use linguas_ja; then
		dodoc NEWS.ja README.ja doc/HACKING.ja || die "dodoc failed"
	else
		rm -f "${D}"/usr/share/info/riece-ja.info*
	fi
}
