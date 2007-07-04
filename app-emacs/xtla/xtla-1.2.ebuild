# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xtla/xtla-1.2.ebuild,v 1.3 2007/07/04 23:26:09 opfer Exp $

inherit elisp

DESCRIPTION="The Emacs interface to GNU TLA"
HOMEPAGE="http://wiki.gnuarch.org/moin.cgi/xtla
	https://gna.org/projects/xtla-el
	http://www.gnu.org/software/gnu-arch/"
SRC_URI="http://download.gna.org/xtla-el/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="${DEPEND}
	|| ( dev-util/bazaar dev-util/tla )"

IUSE=""

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf --with-emacs=/usr/bin/emacs --with-lispdir=${SITELISP}/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} lisp/*.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo texinfo/xtla.info
	dodoc ChangeLog COPYING INSTALL docs/*
}
