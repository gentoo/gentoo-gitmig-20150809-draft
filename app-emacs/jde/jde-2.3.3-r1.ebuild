# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jde/jde-2.3.3-r1.ebuild,v 1.1 2005/01/12 18:09:48 mkennedy Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="Java Development Environment for Emacs"
HOMEPAGE="http://jdee.sunsite.dk/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/emacs
	>=virtual/jdk-1.2.2
	app-emacs/eieio
	app-emacs/semantic
	app-emacs/elib"

src_unpack() {
	unpack ${A}
	# Fix for CVS versions of Emacs http://www.mail-archive.com/jde@sunsite.dk/msg07917.html
	epatch ${FILESDIR}/${PV}-jde-new-buffer-menu-gentoo.patch || die
}

src_compile() {
	cd ${S}/lisp
	rm -f jde-compile-script-init
	for i in ${SITELISP}/eieio ${SITELISP}/semantic ${PWD}
	do
		echo "(add-to-list 'load-path \"$i\")" >>jde-compile-script-init
	done
	emacs -batch -l jde-compile-script-init -f batch-byte-compile *.el
}

src_install() {
	dodir ${SITELISP}/${PN}
	cp -r java ${D}/${SITELISP}/${PN}/

	dodir /usr/share/doc/${P}
	cp -r doc/* ${D}/usr/share/doc/${P}/

	cd ${S}/lisp
	elisp-install ${PN}/lisp *.el *.elc *.bnf

	elisp-site-file-install ${FILESDIR}/70jde-gentoo.el
	exeinto /usr/bin
	doexe jtags*
	dodoc ChangeLog ReleaseNotes.txt
}
