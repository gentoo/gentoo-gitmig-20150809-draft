# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mule-ucs/mule-ucs-0.84-r1.ebuild,v 1.2 2004/04/06 03:47:37 vapier Exp $

inherit elisp-common eutils

MY_PN="Mule-UCS"
MY_P="${MY_PN}-${PV}"
MY_PATCH="${P}+tats20021216"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A character code translator."
HOMEPAGE="http://www.m17n.org/mule/ http://tats.iris.ne.jp/mule-ucs/"
SRC_URI="ftp://ftp.m17n.org/pub/mule/Mule-UCS/${MY_P}.tar.gz
	http://tats.iris.ne.jp/mule-ucs/${MY_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"

DEPEND="virtual/emacs"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${MY_PATCH}.diff.gz
}

src_compile() {
	emacs -q --no-site-file -batch -l mucs-comp.el || die
	pushd lisp/big5conv
	emacs -q --no-site-file -batch -l big5-comp.el || die
	popd
	pushd lisp/jisx0213
	emacs -q --no-site-file -batch -l x0213-comp.el || die
	popd
}

src_install() {
	elisp-install ${MY_PN} lisp/*.el{,c}
	elisp-install ${MY_PN}/big5conv lisp/big5conv/*.el{,c}
	elisp-install ${MY_PN}/jisx0213 lisp/jisx0213/*.el{,c}
	elisp-install ${MY_PN}/reldata lisp/reldata/*.el

	dodoc lisp/ChangeLog lisp/MuleUni.txt lisp/README* doc/mule-ucs*
	newdoc lisp/big5conv/README README.big5conv
	newdoc lisp/jisx0213/ChangeLog ChangeLog.jisx0213
	newdoc lisp/jisx0213/readme.txt readme.txt.jisx0213
}
