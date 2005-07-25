# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xtla/xtla-1.1.ebuild,v 1.1 2005/07/25 18:50:20 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="XTLA - The Emacs interface to GNU TLA"
HOMEPAGE="http://wiki.gnuarch.org/moin.cgi/xtla
	https://gna.org/projects/xtla-el
	http://www.gnu.org/software/gnu-arch/"
SRC_URI="http://download.gna.org/xtla-el/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/emacs"

RDEPEND="${DEPEND}
	|| ( dev-util/bazaar dev-util/tla )"

SITEFILE=50xtla-gentoo.el

src_compile() {
	econf --with-emacs=/usr/bin/emacs --with-lispdir=${SITELISP}/${PN} || die
	make || die
}

src_install() {
	elisp-install ${PN} lisp/*.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	doinfo texinfo/xtla.info
	dodoc ChangeLog COPYING INSTALL docs/*
}
