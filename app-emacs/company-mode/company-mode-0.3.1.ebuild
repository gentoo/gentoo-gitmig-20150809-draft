# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/company-mode/company-mode-0.3.1.ebuild,v 1.2 2009/04/16 22:35:44 fauli Exp $

EAPI=2
NEED_EMACS=22

inherit elisp

DESCRIPTION="In-buffer completion front-end"
HOMEPAGE="http://nschum.de/src/emacs/company-mode/"
SRC_URI="http://nschum.de/src/emacs/${PN}/company-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="semantic"

# Note: company-mode supports many backends, and we refrain from including
# them all in RDEPEND. Only depend on things that are needed at build time.
DEPEND="semantic? ( app-emacs/cedet )
	app-emacs/nxml-mode"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
SITEFILE="50${PN}-gentoo.el"

src_configure() {
	# Disable semantic backend, unless selected by its USE flag
	if ! use semantic; then
		elog "Disabling semantic backend, as requested by USE=-semantic"
		rm "company-semantic.el" || die
		sed -i -e "s/company-semantic *//" company.el || die
	fi
}
