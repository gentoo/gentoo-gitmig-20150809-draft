# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/calfw/calfw-0.1.ebuild,v 1.1 2011/04/10 16:47:10 naota Exp $

EAPI=3

inherit elisp-common eutils

DESCRIPTION="A calendar framework for Emacs"
HOMEPAGE="https://github.com/kiwanami/emacs-calfw"
SRC_URI="https://github.com/kiwanami/emacs-calfw/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="howm"

DEPEND="howm? ( app-emacs/howm )"
RDEPEND="${DEPEND}"

COMMON_ELISPS="calfw.el
calfw-ical.el"

src_prepare() {
	mv kiwanami-emacs-calfw-* "${P}"
	cd "${P}"
	epatch "${FILESDIR}"/${PN}-0.1-cl.patch
	use howm && epatch "${FILESDIR}"/${PN}-0.1-howm-menu.patch
}

src_compile() {
	use howm && (elisp-compile calfw-howm.el || die)
	for x in ${COMMON_ELISPS}; do elisp-compile $x || die; done
}

src_install() {
	use howm && elisp-install ${PN} calfw-howm.el calfw-howm.elc
	for x in ${COMMON_ELISPS}; do elisp-install ${x} ${x}; done
}
