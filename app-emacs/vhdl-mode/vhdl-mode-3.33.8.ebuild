# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vhdl-mode/vhdl-mode-3.33.8.ebuild,v 1.1 2006/03/06 06:03:53 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="VHDL-mode for Emacs"
HOMEPAGE="http://opensource.ethz.ch/emacs/vhdl-mode.html"
SRC_URI="http://opensource.ethz.ch/emacs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"

DEPEND="|| ( app-emacs/cedet app-emacs/speedbar )"

SITEFILE=50vhdl-mode-gentoo.el

src_unpack() {
	unpack ${A}
	rm ${S}/{sb-image,dframe,speedbar,hideshow,site-start}.el*
}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

