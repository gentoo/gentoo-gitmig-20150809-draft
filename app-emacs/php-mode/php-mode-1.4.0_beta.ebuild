# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/php-mode/php-mode-1.4.0_beta.ebuild,v 1.1 2008/01/01 17:38:28 ulm Exp $

inherit elisp eutils

DESCRIPTION="GNU Emacs major mode for editing PHP code"
HOMEPAGE="http://php-mode.sourceforge.net"
SRC_URI="mirror://gentoo/${P/_/-}.tar.bz2"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${P/_/-}"

SITEFILE=51${PN}-gentoo.el
DOCS="ChangeLog"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-conditional-key.patch"
	epatch "${FILESDIR}/${PN}-info-direntry.patch"
}

src_compile() {
	elisp_src_compile
	makeinfo ${PN}.texi || die "makeinfo failed"
}

src_install() {
	elisp_src_install
	doinfo ${PN}.info*
}
