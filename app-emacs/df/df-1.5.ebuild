# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/df/df-1.5.ebuild,v 1.3 2004/06/01 14:09:04 vapier Exp $

inherit elisp

IUSE=""

DESCRIPTION="Displays space left on a device in the mode line"
HOMEPAGE="http://groups.google.com/groups?selm=ye4ww2cbiry.fsf%40alpha4.bocal.cs.univ-paris8.fr"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50df-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/df.el for the complete documentation."
	einfo ""
	einfo "Add something like:"
	einfo ""
	einfo "(df \"/home\")"
	einfo ""
	einfo "to your ~/.emacs"
}

pkg_postrm() {
	elisp-site-regen
}
