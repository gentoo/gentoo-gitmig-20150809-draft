# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lyskom-elisp-client/lyskom-elisp-client-0.47.1.ebuild,v 1.1 2004/03/19 19:41:12 usata Exp $

inherit elisp

IUSE=""

MY_P="${PN}-all-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Elisp client for the LysKOM conference system"
HOMEPAGE="http://www.lysator.liu.se/lyskom/klienter/emacslisp/index.en.html"
SRC_URI="http://www.lysator.liu.se/lyskom/klienter/emacslisp/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

SITEFILE=50lyskom-elisp-client-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	mv lyskom-all-${PV}.el lyskom.el
}

src_install() {
	elisp-install ${PN} *.el*
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc COPYING NEWS-* README
}

pkg_postinst() {
	elisp-site-regen
	ewarn
	ewarn "If you prefer Swedish language environment, add"
	ewarn "\t(setq-default kom-default-language 'sv)"
	ewarn "to your emacs configuration file."
	ewarn
}

pkg_postrm() {
	elisp-site-regen
}
