# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bbdb/bbdb-2.34.ebuild,v 1.1 2003/01/02 05:40:10 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="The Big Brother Database"
HOMEPAGE="http://bbdb.sourceforge.net/"
SRC_URI="http://bbdb.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-emacs=emacs || die "./configure failed"
	make || die
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50bbdb-gentoo.el
	
	doinfo texinfo/*.info*
	dodoc ChangeLog INSTALL README
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
