# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-2.0.1.ebuild,v 1.1 2010/07/01 13:07:09 fauli Exp $

EAPI=3

inherit eutils elisp

DESCRIPTION="An Objective Caml/Camllight mode for Emacs"
HOMEPAGE="https://forge.ocamlcore.org/projects/tuareg/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/410/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/tuareg-${PV}

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	epatch "${FILESDIR}"/${P}-make_install.patch
}

src_install() {
	emake DEST="${D}/usr/share/emacs/site-lisp/tuareg-mode" install || die
	dodoc HISTORY README || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
