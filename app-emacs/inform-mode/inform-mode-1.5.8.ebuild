# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/inform-mode/inform-mode-1.5.8.ebuild,v 1.1 2002/11/20 05:01:33 mkennedy Exp $

inherit elisp 

IUSE=""

DESCRIPTION="A major mode for editing Inform programs."
HOMEPAGE="http://rupert-lane.org/inform-mode/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}"

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
