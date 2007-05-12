# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ocaml-mode/ocaml-mode-3.09.3.ebuild,v 1.2 2007/05/12 09:04:34 ulm Exp $

inherit elisp

MY_P=${P/-mode/}

DESCRIPTION="Emacs mode for OCaml"
HOMEPAGE="http://www.ocaml.org/"
SRC_URI="http://caml.inria.fr/distrib/${MY_P}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}/emacs"
SITEFILE=50${PN}-gentoo.el

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc README README.itz || die "dodoc failed"
}
