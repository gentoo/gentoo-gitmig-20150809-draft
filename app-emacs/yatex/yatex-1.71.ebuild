# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.71.ebuild,v 1.2 2003/10/07 14:36:18 usata Exp $

inherit elisp

IUSE="cjk"

DESCRIPTION="YaTeX: Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="${RDEPEND}
	cjk? ( app-i18n/nkf )"
RDEPEND="virtual/emacs"

S=${WORKDIR}/${P/-/}

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	local yahtml common lisp yahtmllisp
	yahtml="yahtml.el"
	common="yatexlib.el yatexprc.el"
	lisp="comment.el yatex.el yatexadd.el yatexgen.el
		yatexenv.el ${common} yatexmth.el
		yatexhks.el yatexhlp.el yatexm-o.el yatexsec.el
		yatexhie.el ${yahtml}"
	yahtmllisp="${yahtml} ${common}"

	emacs -q --no-site-file -batch \
		-l ${FILESDIR}/lp.el \
		-l ./yatexlib.el \
		-e batch-byte-compile ${lisp} || die
	emacs -q --no-site-file -batch \
		-l ${FILESDIR}/lp.el \
		-l ./yatexlib.el \
		-e bcf-and-exit ${yahtmllisp} || die

	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if [ -n "`use cjk`" ] ; then
		nkf -e yatexj > yatex-ja.info
		nkf -e yahtmlj > yahtml-ja.info
	fi
}

src_install() {

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/50yatex-gentoo.el

	dodoc help/YATEXHLP.eng docs/*.eng
	if [ -n "`use cjk`" ] ; then
		dodoc 00readme install help/YATEXHLP.jp
		dodoc docs/{htmlqa,qanda} docs/*.doc
	fi
	for i in docs/*.info; do
		doinfo ${i}
	done
}
