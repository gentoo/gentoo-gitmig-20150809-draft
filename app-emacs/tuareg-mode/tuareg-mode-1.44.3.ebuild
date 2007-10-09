# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.44.3.ebuild,v 1.4 2007/10/09 06:52:13 ulm Exp $

inherit elisp

DESCRIPTION="Tuareg is a Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_compile() {
	einfo "Bytecode compilation not available"
}

src_install() {
	elisp-install ${PN} *.el || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc HISTORY LISEZMOI README
}
