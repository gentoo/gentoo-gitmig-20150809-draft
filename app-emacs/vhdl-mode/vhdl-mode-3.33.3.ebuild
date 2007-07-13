# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vhdl-mode/vhdl-mode-3.33.3.ebuild,v 1.3 2007/07/13 07:25:16 mr_bones_ Exp $

inherit elisp

IUSE=""

DESCRIPTION="VHDL-mode for Emacs"
HOMEPAGE="http://opensource.ethz.ch/emacs/vhdl-mode.html"
SRC_URI="http://opensource.ethz.ch/emacs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"

DEPEND="virtual/emacs"

SITEFILE=50vhdl-mode-gentoo.el

# do these manually because we only want vhdl-mode right now.  The other .el
# files are only needed for dependencies that need to be figured out
src_compile() {
	elisp-compile vhdl-mode.el speedbar.el dframe.el sb-image.el
}

src_install() {
	elisp-install ${PN} vhdl-mode.el* speedbar.el* dframe.el* sb-image.el*
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
