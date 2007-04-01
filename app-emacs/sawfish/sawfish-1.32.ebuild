# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sawfish/sawfish-1.32.ebuild,v 1.4 2007/04/01 10:05:35 hansmi Exp $

inherit elisp

DESCRIPTION="Sawfish is an GNU Emacs mode for writing code for the Sawfish window manager with support for a REPL."
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/sawfish-mode-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/emacs
	x11-wm/sawfish"

SITEFILE=50sawfish-gentoo.el

S=${WORKDIR}/sawfish-mode-${PV}

src_unpack() {
	unpack ${A}
	mv ${S}/sawfish-mode.el ${S}/sawfish.el
}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
