# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/limit/limit-1.14.10_pre20070618.ebuild,v 1.1 2007/08/27 09:16:20 ulm Exp $

inherit elisp versionator

MY_PV=( $(get_version_components) )
MY_PV[4]="1057"
MY_P="${PN}-${MY_PV[0]}_${MY_PV[1]}-${MY_PV[3]#pre}${MY_PV[4]}"

DESCRIPTION="Library about Internet Message, for IT generation"
HOMEPAGE="http://pure.fan.gr.jp/simm/?MyWorks"
SRC_URI="http://www.jpl.org/ftp/pub/m17n/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="!app-emacs/flim
	>=app-emacs/apel-10.3"

S="${WORKDIR}/${MY_P}"
SITEFILE=60flim-gentoo.el

src_compile() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" install \
		|| die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog || die "dodoc failed"
}
