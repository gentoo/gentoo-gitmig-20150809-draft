# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.73.ebuild,v 1.2 2008/08/28 06:23:51 ulm Exp $

inherit elisp eutils

DESCRIPTION="Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="as-is"
IUSE="linguas_ja"

S=${WORKDIR}/${P/-/}
SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	# compilation b0rks

	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if use linguas_ja; then
		iconv -f ISO-2022-JP -t EUC-JP yatexj > yatex-ja.info
		iconv -f ISO-2022-JP -t EUC-JP yahtmlj > yahtml-ja.info
	fi
}

src_install() {
	elisp-install ${PN} *.el || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"

	insinto ${SITEETC}/${PN}
	doins help/YATEXHLP.* || die "doins failed"

	doinfo docs/*.info || die "doinfo failed"

	dodoc docs/*.eng || die "dodoc failed"
	if use linguas_ja; then
		dodoc 00readme install docs/{htmlqa,qanda} docs/*.doc \
			|| die "dodoc failed"
	fi
}
