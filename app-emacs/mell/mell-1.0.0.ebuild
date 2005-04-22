# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mell/mell-1.0.0.ebuild,v 1.11 2005/04/22 16:53:11 matsuu Exp $

inherit elisp

IUSE=""

DESCRIPTION="MELL -- M Emacs Lisp Library"
HOMEPAGE="http://taiyaki.org/elisp/mell/"
SRC_URI="http://taiyaki.org/elisp/mell/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 alpha ~amd64 ppc ~ppc64"
SLOT="0"

DEPEND="virtual/emacs"

src_compile() {

	econf --with-emacs-sitelispdir=${D}/usr/share/emacs/site-lisp \
			--with-mell-docdir=${D}/usr/share/doc/${PF}/html \
			|| die
	emake || die

}

src_install() {

	einstall || die
	elisp-site-file-install ${FILESDIR}/50mell-gentoo.el
	dosed ${SITELISP}/init-mell.el || die "dosed failed"

	dodoc [A-Z][A-Z]* ChangeLog

}
