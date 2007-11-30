# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-5.15.ebuild,v 1.1 2007/11/30 07:32:49 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

SITEFILE="51${PN}-gentoo.el"

S="${WORKDIR}/org-${PV}"

src_compile() {
	elisp_src_compile
	emake info || die "emake info failed"
	mv org org.info || die "Infofile could not be renamed"
}

src_install() {
	elisp_src_install
	doinfo *.info
	dodoc README org.pdf orgcard.pdf || die "dodoc failed"
}
