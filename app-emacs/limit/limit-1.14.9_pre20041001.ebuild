# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/limit/limit-1.14.9_pre20041001.ebuild,v 1.8 2007/07/04 23:01:17 opfer Exp $

inherit elisp

DESCRIPTION="Library about Internet Message, for IT generation"
HOMEPAGE="http://pure.fan.gr.jp/simm/?MyWorks"
# SRC_URI="ftp://ftp.fan.gr.jp/pub/elisp/limit/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P/_pre/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_pre/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc-macos sparc x86"
IUSE=""

DEPEND="!app-emacs/flim
	>=app-emacs/apel-10.3"

S=${WORKDIR}/flim
SITEFILE=60flim-gentoo.el

src_compile() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" install || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog
}
