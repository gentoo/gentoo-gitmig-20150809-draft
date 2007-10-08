# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lookup/lookup-1.4-r1.ebuild,v 1.1 2007/10/08 15:48:13 ulm Exp $

inherit elisp

DESCRIPTION="An interface to search CD-ROM books and network dictionaries"
HOMEPAGE="http://openlab.jp/edict/lookup/"
SRC_URI="http://openlab.jp/edict/lookup/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

src_compile() {
	econf || die
	# parallel make fails with Emacs deadlock
	emake -j1 || die
}

src_install() {
	einstall lispdir="${D}${SITELISP}/${PN}" || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
