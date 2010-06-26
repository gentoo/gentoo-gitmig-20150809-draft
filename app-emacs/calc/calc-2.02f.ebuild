# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/calc/calc-2.02f.ebuild,v 1.8 2010/06/26 12:31:38 ulm Exp $

inherit elisp

DESCRIPTION="Advanced calculator and mathematical tool within Emacs"
HOMEPAGE="http://www.gnu.org/software/emacs/calc.html"
SRC_URI="mirror://gnu/calc/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

ELISP_PATCHES="${P}-emacs-21.patch ${P}-info-dir.patch"
SITEFILE="50${PN}-gentoo.el"

pkg_setup() {
	local have_emacs=$(elisp-emacs-version)
	if [ "${have_emacs%%.*}" -ge 22 ]; then
		echo
		elog "Please note that \"${PN}\" is already included with Emacs 22 or"
		elog "later, so ${CATEGORY}/${PN} is only needed for lower versions."
		elog "You may select the active Emacs version with \"eselect emacs\"."
	fi
}

src_compile() {
	emake compile info || die "emake failed"
}

src_install() {
	elisp-install ${PN} calc*.el calc*.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	# prevent inclusion of package dir by subdirs.el
	touch "${D}${SITELISP}/${PN}/.nosearch"

	doinfo calc.info*
	dodoc README README.prev
}
