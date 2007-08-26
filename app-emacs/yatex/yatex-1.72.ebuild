# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.72.ebuild,v 1.13 2007/08/26 20:11:09 ulm Exp $

inherit elisp eutils

DESCRIPTION="Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"
SLOT="0"
LICENSE="as-is"
IUSE="cjk"

S=${WORKDIR}/${P/-/}
SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-yatexhlp-gentoo.diff"
}

src_compile() {
	# compilation b0rks on alpha, sparc and ppc
	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if use cjk ; then
		iconv -f ISO-2022-JP -t EUC-JP yatexj > yatex-ja.info
		iconv -f ISO-2022-JP -t EUC-JP yahtmlj > yahtml-ja.info
	fi
}

src_install() {

	elisp-install ${PN} *.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	elisp-install ${PN} help/YATEXHLP*

	dodoc docs/*.eng
	if use cjk ; then
		dodoc 00readme install
		dodoc docs/{htmlqa,qanda} docs/*.doc
	fi
	for i in docs/*.info; do
		doinfo ${i}
	done
}
