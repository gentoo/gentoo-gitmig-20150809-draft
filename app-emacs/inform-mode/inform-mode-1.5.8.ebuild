# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/inform-mode/inform-mode-1.5.8.ebuild,v 1.11 2005/01/01 13:50:29 eradicator Exp $

inherit elisp

IUSE=""

DESCRIPTION="A major mode for editing Inform programs."
HOMEPAGE="http://rupert-lane.org/inform-mode/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

DEPEND="virtual/emacs"

S="${WORKDIR}/${PN}"

src_compile() {
	emacs --batch -f batch-byte-compile \
		--no-site-file --no-init-file *.el \
		|| die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/50inform-mode-gentoo.el
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
