# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cmail/cmail-2.62.ebuild,v 1.7 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

DESCRIPTION="A simple mail management system for Emacs"
HOMEPAGE="http://cmail.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/2191/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	app-emacs/apel
	virtual/flim
	virtual/semi"

SITEFILE="70cmail-gentoo.el"

src_compile() {
	make || die
}

src_install() {
	make \
		LISPDIR=${D}/${SITELISP} \
		INFODIR=${D}/usr/share/info \
		install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc ChangeLog INTRO* README* RELNOTES*
	dodoc doc/FAQ doc/README* doc/cmail-r2c* doc/glossary
	dodoc sample*
}
