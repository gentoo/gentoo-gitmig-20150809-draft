# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-3.9.5.ebuild,v 1.11 2007/10/08 14:38:32 opfer Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE=50sml-mode-gentoo.el

src_unpack() {
	unpack ${A}
	cat "${FILESDIR}/${SITEFILE}" "${S}/sml-mode-startup.el" >"${WORKDIR}/${SITEFILE}"
}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${WORKDIR}/${SITEFILE}"
	doinfo *.info*
	dodoc BUGS ChangeLog NEWS README TODO INSTALL
}
