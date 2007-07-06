# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-2.32-r2.ebuild,v 1.1 2007/07/06 16:43:03 ulm Exp $

inherit elisp

DESCRIPTION="ECB is a source code browser for Emacs"
HOMEPAGE="http://ecb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="java"

DEPEND="
	|| ( app-emacs/cedet
		( >=app-emacs/speedbar-0.14_beta4
		>=app-emacs/semantic-1.4
		>=app-emacs/eieio-0.17 ) )
	java? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

SITEFILE=71${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s%./info-help%../../../info%" \
		-e "s%./html-help%../../../doc/${P}/html%" \
		-e "/defconst/s%ecb.info%ecb.info.gz%" \
		ecb-help.el
}

src_compile() {
	local loadpath=""
	if use java; then
		loadpath="${SITELISP}/elib ${SITELISP}/jde/lisp"
	fi

	if has_version app-emacs/cedet; then
		einfo "Building with CEDET"
		emake CEDET=${SITELISP}/cedet LOADPATH="${loadpath}" \
			|| die "emake failed"
	else
		einfo "Building with SEMANTIC, EIEIO and SPEEDBAR"
		emake SEMANTIC=${SITELISP}/semantic EIEIO=${SITELISP}/eieio \
			SPEEDBAR=${SITELISP}/speedbar CEDET="" LOADPATH="${loadpath}" \
			|| die "emake failed"
	fi
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	insinto ${SITELISP}/${PN}
	doins -r ecb-images

	dodoc NEWS README RELEASE_NOTES || die "dodoc failed"
	doinfo info-help/ecb.info*
	dohtml html-help/*.html
}
