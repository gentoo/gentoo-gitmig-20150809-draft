# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mailcrypt/mailcrypt-3.5.8-r1.ebuild,v 1.5 2007/07/04 23:07:57 opfer Exp $

inherit elisp

DESCRIPTION="Provides a simple interface to public key cryptography with OpenPGP."
HOMEPAGE="http://mailcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mailcrypt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="amd64 ppc sparc x86"

RDEPEND="${DEPEND}
	app-crypt/gnupg"
RESTRICT="test"
SITEFILE=50${PN}-gentoo.el

src_compile() {
	export EMACS=/usr/bin/emacs
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall lispdir="${D}/${SITELISP}/${PN}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ANNOUNCE ChangeLog* INSTALL LCD-entry mailcrypt.dvi NEWS ONEWS README*
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "See /usr/share/doc/${P}/INSTALL.gz for how to customize mailcrypt"
	elog
}
