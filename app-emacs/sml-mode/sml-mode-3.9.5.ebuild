# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-3.9.5.ebuild,v 1.6 2004/11/21 04:24:41 kingtaco Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="ftp://ftp.research.bell-labs.com/dist/smlnj/contrib/emacs/"
SRC_URI="ftp://ftp.research.bell-labs.com/dist/smlnj/contrib/emacs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos ~amd64"
IUSE=""

SITEFILE=50sml-mode-gentoo.el

src_unpack() {
	unpack ${A}
	cat ${FILESDIR}/${SITEFILE} ${S}/sml-mode-startup.el >${WORKDIR}/${SITEFILE}
}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${WORKDIR}/${SITEFILE}
	doinfo *.info*
	dodoc BUGS ChangeLog NEWS README TODO INSTALL
}
