# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/blogmax/blogmax-20041208.ebuild,v 1.1 2005/01/25 22:05:12 mkennedy Exp $

inherit elisp

DESCRIPTION="BlogMax: Blogging in Emacs"
HOMEPAGE="http://billstclair.com/blogmax/index.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}; rm -f *.elc
}

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install ${PN} blogmax.{el,elc}
	elisp-site-file-install ${FILESDIR}/50blogmax-gentoo.el
	dodoc gpl.txt ${FILESDIR}/README.Gentoo
	dodir /usr/share/doc/${PF}/example
	cp -r * ${D}/usr/share/doc/${PF}/example
	pushd ${D}/usr/share/doc/${PF}/example
	rm -f blogmax.{el,elc}
}
