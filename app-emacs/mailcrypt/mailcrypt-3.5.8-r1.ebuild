# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mailcrypt/mailcrypt-3.5.8-r1.ebuild,v 1.3 2007/05/28 14:23:14 opfer Exp $

inherit elisp

DESCRIPTION="Provides a simple interface to public key cryptography with OpenPGP."
HOMEPAGE="http://mailcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mailcrypt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="x86 ~amd64 ppc sparc"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	app-crypt/gnupg"

src_compile() {
	export EMACS=/usr/bin/emacs
	econf || die
	make || die
}

src_test() {
	.
}

src_install() {
	einstall lispdir="${D}/${SITELISP}/${PN}" || die
	elisp-site-file-install "${FILESDIR}/50mailcrypt-gentoo.el"
	dodoc ANNOUNCE ChangeLog* INSTALL LCD-entry mailcrypt.dvi NEWS ONEWS README*
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "See /usr/share/doc/${P}/INSTALL.gz for how to customize mailcrypt"
	elog
}

pkg_postrm() {
	elisp-site-regen
}
