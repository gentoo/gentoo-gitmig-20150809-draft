# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mell/mell-1.0.0.ebuild,v 1.2 2003/12/24 22:55:08 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="MELL -- M Emacs Lisp Library"
HOMEPAGE="http://taiyaki.org/elisp/mell/"
SRC_URI="http://taiyaki.org/elisp/mell/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${P}"

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

	dodoc [A-Z][A-Z]* ChangeLog

}
