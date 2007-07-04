# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cmail/cmail-2.62.ebuild,v 1.9 2007/07/04 23:04:25 opfer Exp $

inherit elisp

DESCRIPTION="A simple mail management system for Emacs"
HOMEPAGE="http://cmail.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/2191/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="${DEPEND}
	app-emacs/apel
	virtual/flim
	app-emacs/semi"

SITEFILE="70cmail-gentoo.el"

src_compile() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" install || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die "elisp-site-file-install failed"

	dodoc ChangeLog INTRO* README* RELNOTES*
	dodoc doc/FAQ doc/README* doc/cmail-r2c* doc/glossary
	dodoc sample*
}
