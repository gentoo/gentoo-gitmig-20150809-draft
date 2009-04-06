# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-2.32-r3.ebuild,v 1.2 2009/04/06 14:07:55 ranger Exp $

inherit elisp eutils

DESCRIPTION="Source code browser for Emacs"
HOMEPAGE="http://ecb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="java"

DEPEND="app-emacs/cedet
	java? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

SITEFILE="71${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i -e "s:@PF@:${PF}:" ecb-help.el || die "sed failed"
}

src_compile() {
	local loadpath=""
	if use java; then
		loadpath="${SITELISP}/elib ${SITELISP}/jde ${SITELISP}/jde/lisp"
	fi

	emake CEDET="${SITELISP}/cedet" LOADPATH="${loadpath}" \
		|| die "emake failed"
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r ecb-images || die

	doinfo info-help/ecb.info* || die
	dohtml html-help/*.html || die
	dodoc NEWS README RELEASE_NOTES || die
}

pkg_postinst() {
	elisp-site-regen
	elog "ECB is now autoloaded in site-gentoo.el. Add the line"
	elog "  (require 'ecb)"
	elog "to your ~/.emacs file to enable all features on Emacs startup."
}
