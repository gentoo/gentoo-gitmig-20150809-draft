# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.71.ebuild,v 1.5 2004/04/04 17:01:08 usata Exp $

inherit elisp eutils

IUSE="cjk"

DESCRIPTION="YaTeX: Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="x86 alpha ~sparc ~ppc"
SLOT="0"
LICENSE="as-is"

DEPEND="${RDEPEND}
	cjk? ( app-i18n/nkf )"
RDEPEND="virtual/emacs"

S=${WORKDIR}/${P/-/}

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-yatexhlp-gentoo.diff
}

src_compile() {

	# compilation b0rks on alpha, sparc and ppc

	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if [ -n "`use cjk`" ] ; then
		nkf -e yatexj > yatex-ja.info
		nkf -e yahtmlj > yahtml-ja.info
	fi
}

src_install() {

	elisp-install ${PN} *.el
	elisp-site-file-install ${FILESDIR}/50yatex-gentoo.el
	elisp-install ${PN} help/YATEXHLP*

	dodoc docs/*.eng
	if [ -n "`use cjk`" ] ; then
		dodoc 00readme install
		dodoc docs/{htmlqa,qanda} docs/*.doc
	fi
	for i in docs/*.info; do
		doinfo ${i}
	done
}
