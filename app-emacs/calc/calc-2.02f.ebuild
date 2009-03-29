# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/calc/calc-2.02f.ebuild,v 1.7 2009/03/29 21:16:30 ulm Exp $

inherit elisp versionator

DESCRIPTION="Advanced calculator and mathematical tool within Emacs"
HOMEPAGE="http://www.gnu.org/software/emacs/calc.html"
SRC_URI="mirror://gnu/calc/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

ELISP_PATCHES="${P}-emacs-21.patch ${P}-info-dir.patch"
SITEFILE="50calc-gentoo.el"

pkg_setup() {
	if version_is_at_least 22 "$(elisp-emacs-version)"; then
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
