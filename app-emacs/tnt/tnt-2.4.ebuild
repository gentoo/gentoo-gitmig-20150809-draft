# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tnt/tnt-2.4.ebuild,v 1.9 2007/01/28 04:33:20 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Client for the AOL Instant Messenging service using the Emacs text editor as it's UI."
HOMEPAGE="http://tnt.sourceforge.net/"
SRC_URI="mirror://sourceforge/tnt/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="virtual/emacs"

src_compile() {
	make clean && make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/50tnt-gentoo.el
	dodoc ChangeLog INSTALL PROTOCOL README TODO
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "See /usr/share/doc/${P}/README.gz for how to use TNT"
	elog "Use the following to start TNT:"
	elog "	M-x tnt RET"
	elog
}

pkg_postrm() {
	elisp-site-regen
}
