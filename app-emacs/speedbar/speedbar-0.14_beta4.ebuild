# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/speedbar/speedbar-0.14_beta4.ebuild,v 1.6 2004/09/23 05:20:43 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="Allows you to create a special frame with a specialized directory listing in it."
HOMEPAGE="http://cedet.sourceforge.net/speedbar.shtml"
SRC_URI="mirror://sourceforge/cedet/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/emacs
	!app-emacs/cedet"

S="${WORKDIR}/${P/_/}"

SITEFILE=50speedbar-gentoo.el

src_compile() {
	make || die
	make opt || die
}

src_install() {
	elisp-install ${PN} *.el *.elc *.xpm
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog INSTALL
	doinfo speedbar.info
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
