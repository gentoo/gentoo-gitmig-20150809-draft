# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/remember/remember-1.9.ebuild,v 1.1 2006/08/31 23:58:43 jmglov Exp $

inherit elisp

DESCRIPTION="Simplify writing short notes in emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/RememberMode"

# Upstream releases

SRC_URI="http://download.gna.org/remember-el/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bbdb planner"
RDEPEND="virtual/emacs"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	bbdb? ( app-emacs/bbdb )
	planner? ( app-emacs/planner )"

SITEFILE=50remember-gentoo.el

src_compile() {
	emake || die
}

src_install() {
	doinfo remember-el.info
	dodoc ChangeLog
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
