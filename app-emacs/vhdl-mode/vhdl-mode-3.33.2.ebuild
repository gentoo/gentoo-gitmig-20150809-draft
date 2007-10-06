# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vhdl-mode/vhdl-mode-3.33.2.ebuild,v 1.8 2007/10/06 19:58:27 ulm Exp $

inherit elisp

DESCRIPTION="VHDL-mode for Emacs"
HOMEPAGE="http://opensource.ethz.ch/emacs/vhdl-mode.html"
SRC_URI="http://opensource.ethz.ch/emacs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50vhdl-mode-gentoo.el

# do these manually because we only want vhdl-mode right now.  The other .el
# files are only needed for dependencies that need to be figured out
src_compile() {
	/usr/bin/emacs --batch -f batch-byte-compile --no-site-file --no-init-file vhdl-mode.el || die
}

src_install() {
	elisp-install ${PN} vhdl-mode.el vhdl-mode.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}
