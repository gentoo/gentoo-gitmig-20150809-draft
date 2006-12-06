# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.83.ebuild,v 1.8 2006/12/06 15:37:47 opfer Exp $

inherit elisp eutils latex-package autotools

DESCRIPTION="AUCTeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="preview-latex"

DEPEND="preview-latex? ( !dev-tex/preview-latex app-text/dvipng virtual/ghostscript )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# skip XEmacs detection. this is a workaround for emacs23
	epatch ${FILESDIR}/${PN}-11.82-configure.diff
}

src_compile() {
	econf --disable-build-dir-test \
		--with-auto-dir=${D}/var/lib/auctex \
		--with-lispdir=${D}/usr/share/emacs/site-lisp \
		$(use_enable preview-latex preview) || die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dosed ${SITELISP}/tex-site.el || die
	elisp-site-file-install ${FILESDIR}/51auctex-gentoo.el
	if use preview-latex; then
	   elisp-site-file-install ${FILESDIR}/60auctex-gentoo.el
	fi
	dodoc ChangeLog CHANGES README RELEASE TODO FAQ INSTALL*
}

pkg_postinst() {
	# rebuild TeX-inputfiles-database
	use preview-latex && latex-package_pkg_postinst
	elisp-site-regen
}

pkg_postrm(){
	 use preview-latex && latex-package_pkg_postrm
	 elisp-site-regen
}
