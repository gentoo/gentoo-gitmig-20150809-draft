# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sawfish/sawfish-1.31.ebuild,v 1.1 2004/06/26 19:19:46 mkennedy Exp $

inherit elisp

DESCRIPTION="Sawfish is an GNU Emacs mode for writing code for the Sawfish window manager with support for a REPL."
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/sawfish-mode-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/emacs
	x11-wm/sawfish"

SITEFILE=50sawfish-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
