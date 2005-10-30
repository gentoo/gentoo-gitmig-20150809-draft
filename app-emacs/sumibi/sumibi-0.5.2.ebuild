# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sumibi/sumibi-0.5.2.ebuild,v 1.1 2005/10/30 10:05:27 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="Statistical Japanese input method using the Internet as a large corpus"
HOMEPAGE="http://www.sumibi.org/"
SRC_URI="mirror://sourceforge.jp/sumibi/17176/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=""

src_compile() {
	cd client/elisp
	elisp-comp *.el || die
}

src_install() {
	cd client/elisp
	elisp-install ${PN} *.el*
	elisp-site-file-install ${FILESDIR}/50sumibi-gentoo.el

	cd ${S}
	dodoc README CREDITS CHANGELOG
}
