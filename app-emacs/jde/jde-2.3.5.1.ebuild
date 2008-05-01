# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jde/jde-2.3.5.1.ebuild,v 1.7 2008/05/01 19:16:44 ulm Exp $

inherit elisp

DESCRIPTION="Java Development Environment for Emacs"
HOMEPAGE="http://jdee.sourceforge.net/"
SRC_URI="mirror://sourceforge/jdee/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-emacs/elib
	>=app-emacs/cedet-1.0_beta3"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.3"

SITEFILE=70${PN}-gentoo.el

src_compile() {
	cd "${S}"/lisp
	cat >jde-compile-script-init <<-EOF
	(load "${SITELISP}/cedet/common/cedet")
	(add-to-list 'load-path "$PWD")
	EOF
	emacs -batch -l jde-compile-script-init -f batch-byte-compile *.el
}

src_install() {
	dodir ${SITELISP}/${PN}
	cp -r java "${D}"/${SITELISP}/${PN}/
	dodir /usr/share/doc/${P}
	cp -r doc/* "${D}"/usr/share/doc/${P}/
	cd "${S}"/lisp
	elisp-install ${PN}/lisp *.el *.elc *.bnf
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog ReleaseNotes.txt
	find "${D}" -type f -print0 |xargs -0 chmod 644
	exeinto /usr/bin
	doexe jtags*
}
