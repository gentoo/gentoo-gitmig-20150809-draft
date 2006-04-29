# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jde/jde-2.3.5.1.ebuild,v 1.2 2006/04/29 12:08:51 dertobi123 Exp $

inherit elisp eutils

DESCRIPTION="Java Development Environment for Emacs"
HOMEPAGE="http://jdee.sunsite.dk/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="virtual/emacs
	>=virtual/jdk-1.3
	app-emacs/elib
	>=app-emacs/cedet-1.0_beta3"

SITEFILE=70jde-gentoo.el

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}/lisp
	cat >jde-compile-script-init <<EOF
(load "${SITELISP}/cedet/common/cedet")
(add-to-list 'load-path "$PWD")
EOF
	emacs -batch -l jde-compile-script-init -f batch-byte-compile *.el
}

src_install() {
	dodir ${SITELISP}/${PN}
	cp -r java ${D}/${SITELISP}/${PN}/
	dodir /usr/share/doc/${P}
	cp -r doc/* ${D}/usr/share/doc/${P}/
	cd ${S}/lisp
	elisp-install ${PN}/lisp *.el *.elc *.bnf
	cp ${FILESDIR}/${PV}-${SITEFILE} ${S}/${SITEFILE}; elisp-site-file-install ${S}/${SITEFILE}
	dodoc ChangeLog ReleaseNotes.txt
	find ${D} -type f -print0 |xargs -0 chmod 644
	exeinto /usr/bin
	doexe jtags*
}
