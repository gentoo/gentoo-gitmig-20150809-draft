# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mell/mell-1.0.0.ebuild,v 1.13 2007/07/04 23:13:21 opfer Exp $

inherit elisp

DESCRIPTION="M Emacs Lisp Library"
HOMEPAGE="http://taiyaki.org/elisp/mell/"
SRC_URI="http://taiyaki.org/elisp/mell/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ppc ppc64 x86"
SLOT="0"
IUSE=""
SITEFILE=50${PN}-gentoo.el

src_compile() {

	econf --with-emacs-sitelispdir="${D}/usr/share/emacs/site-lisp" \
			--with-mell-docdir="${D}/usr/share/doc/${PF}/html" \
			|| die "econf failed"
	emake || die "emake failed"

}

src_install() {

	einstall || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dosed "${SITELISP}/init-mell.el" || die "dosed failed"

	dodoc [A-Z][A-Z]* ChangeLog

}
