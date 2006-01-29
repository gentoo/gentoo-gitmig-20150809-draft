# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd-el/speechd-el-1.0.ebuild,v 1.1 2006/01/29 03:53:34 williamh Exp $

inherit elisp-common

DESCRIPTION="emacs speech support"
HOMEPAGE="http://www.freebsoft.org/speechd-el"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd-el/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=app-emacs/elib-1.0
	>=app-accessibility/speech-dispatcher-0.5"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	insinto /usr/share/emacs/site-lisp/speechd-el
	doins *.el
	exeinto /usr/bin
	doexe speechd-log-extractor
	dodoc ANNOUNCE ChangeLog EMACSPEAK* NEWS README speechd-speak.pdf
	doinfo speechd-el.info
}

pkg_postinst() {
	einfo "Execute the following command from within emacs to get it to speak:"
	einfo "  M-x load-library RET speechd-speak RET"
}
