# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.76.ebuild,v 1.8 2012/10/11 16:31:17 ulm Exp $

EAPI=4

inherit elisp eutils

DESCRIPTION="Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="~alpha ~amd64 ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="YaTeX"
IUSE="linguas_ja"

S="${WORKDIR}/${P/-/}"
ELISP_PATCHES="${PN}-1.76-gentoo.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	# byte-compilation fails (as of 1.74): yatexlib.el requires fonts
	# that are only available under X
	:
}

src_install() {
	elisp-install ${PN} *.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	insinto ${SITEETC}/${PN}
	doins help/YATEXHLP.eng
	doinfo docs/yatexe docs/yahtmle
	dodoc docs/*.eng

	if use linguas_ja; then
		doins help/YATEXHLP.jp
		doinfo docs/yatexj docs/yahtmlj
		dodoc 00readme install docs/{htmlqa,qanda} docs/*.doc
	fi
}
