# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/navi2ch/navi2ch-1.7.4.ebuild,v 1.11 2007/01/05 16:08:25 flameeyes Exp $

inherit elisp

IUSE=""

DESCRIPTION="Navi2ch is navigator for 2ch which works under many Emacsen"
HOMEPAGE="http://navi2ch.sourceforge.net/"
SRC_URI="mirror://sourceforge/navi2ch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc ppc64 ppc-macos"

DEPEND="virtual/emacs"

SITEFILE=50navi2ch-gentoo.el

src_compile() {
	econf || die
	emake < /dev/null || die
}

src_install() {
	emake < /dev/null \
		DESTDIR=${D} lispdir=${SITELISP}/navi2ch install || die
	elisp-install navi2ch contrib/*.el || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "Please add to your .emacs"
	elog "If you use mona-font,"
	elog "\t(setq navi2ch-mona-enable t)"
	elog "If you use izonmoji-mode,"
	elog "\t(require 'izonmoji-mode)"
	elog "\t(add-hook 'navi2ch-bm-mode-hook	  'izonmoji-mode-on)"
	elog "\t(add-hook 'navi2ch-article-mode-hook 'izonmoji-mode-on)"
	elog "\t(add-hook 'navi2ch-popup-article-mode-hook 'izonmoji-mode-on)"
	elog
}
