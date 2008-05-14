# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/navi2ch/navi2ch-1.7.5_p20070510.ebuild,v 1.3 2008/05/14 17:28:08 opfer Exp $

inherit elisp

MY_PV=${PV#*_p}
DESCRIPTION="A navigator for 2ch"
HOMEPAGE="http://navi2ch.sourceforge.net/"
SRC_URI="http://navi2ch.sourceforge.net/snapshot/${PN}-cvs_0.0.${MY_PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
S="${WORKDIR}/${PN}-cvs-${MY_PV}"

src_compile() {
	econf \
		--with-lispdir=${SITELISP}/${PN} \
		--with-icondir=${SITEETC}/${PN} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-install ${PN} contrib/*.el || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc ChangeLog* NEWS README TODO
	newdoc contrib/README README.contrib
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "Please add to your ~/.emacs"
	elog "If you use mona-font,"
	elog "\t(setq navi2ch-mona-enable t)"
	elog "If you use izonmoji-mode,"
	elog "\t(require 'izonmoji-mode)"
	elog "\t(add-hook 'navi2ch-bm-mode-hook	  'izonmoji-mode-on)"
	elog "\t(add-hook 'navi2ch-article-mode-hook 'izonmoji-mode-on)"
	elog "\t(add-hook 'navi2ch-popup-article-mode-hook 'izonmoji-mode-on)"
	elog
}
