# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lookup/lookup-1.4.1.ebuild,v 1.3 2007/12/01 00:08:26 opfer Exp $

inherit elisp

DESCRIPTION="An interface to search CD-ROM books and network dictionaries"
HOMEPAGE="http://openlab.jp/edict/lookup/"
SRC_URI="http://openlab.jp/edict/lookup/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

src_compile() {
	econf || die "econf failed"
	# parallel make fails with Emacs deadlock
	emake -j1 || die "emake failed"
}

src_install() {
	einstall lispdir="${D}${SITELISP}/${PN}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
