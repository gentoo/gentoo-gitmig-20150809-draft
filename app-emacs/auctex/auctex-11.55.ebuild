# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.55.ebuild,v 1.1 2005/04/02 06:21:15 usata Exp $

inherit elisp

DESCRIPTION="AUCTeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc-macos"
IUSE=""

DEPEND="virtual/tetex"

src_compile() {
	econf --with-auto-dir=${D}/var/lib/auctex \
		--with-lispdir=${D}/usr/share/emacs/site-lisp \
		--with-tex-input-dirs="/usr/share/texmf/tex/;/usr/share/texmf/bibtex/bst/" || die "econf failed"
	emake || die

	# bug #72637
	elisp-comp *.el || die
}

src_install() {
	einstall || die
	elisp-install ${PN} bib-cite.el* tex-jp.el* || die
	dosed ${SITELISP}/tex-site.el || die
	elisp-site-file-install ${FILESDIR}/50auctex-gentoo.el
	dodoc ChangeLog CHANGES README RELEASE TODO FAQ INSTALL*
}
