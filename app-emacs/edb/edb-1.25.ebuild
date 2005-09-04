# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/edb/edb-1.25.ebuild,v 1.2 2005/09/04 03:02:14 swegener Exp $

inherit elisp

DESCRIPTION="EDB, The Emacs Database"
HOMEPAGE="http://www.glug.org/people/ttn/software/edb/"
SRC_URI="http://www.glug.org/people/ttn/software/edb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE="50edb-gentoo.el"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc AUTHORS BUGS COPYING HACKING NEWS PLANS README TODO
	doinfo edb*info
	cp -R examples tests ${D}/usr/share/doc/${PF}/
}
