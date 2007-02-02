# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-4.63.ebuild,v 1.1 2007/02/02 10:02:29 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Org - an Emacs mode for notes and project planning"
HOMEPAGE="http://staff.science.uva.nl/~dominik/Tools/org/"
SRC_URI="http://staff.science.uva.nl/~dominik/Tools/org/org-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

SITEFILE="51${PN}-gentoo.el"

S=${WORKDIR}/org-${PV}

src_compile() {
	elisp_src_compile
	emake info
	mv org org.info || die "Seems the info file was renamed!"
}

src_install() {
	elisp_src_install
	doinfo *.info
}
