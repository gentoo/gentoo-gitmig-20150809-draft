# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tnt/tnt-2.4.ebuild,v 1.3 2003/09/06 22:01:26 msterret Exp $

inherit elisp

IUSE=""

DESCRIPTION="Client for the AOL Instant Messenging service using the Emacs text editor as it's UI."
HOMEPAGE="http://tnt.sourceforge.net/"
SRC_URI="mirror://sourceforge/tnt/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
	einfo ""
	einfo "See /usr/share/doc/${P}/README.gz for how to use TNT"
	einfo "Use the following to start TNT:"
	einfo "	M-x tnt RET"
	einfo ""
}

pkg_postrm() {
	elisp-site-regen
}
