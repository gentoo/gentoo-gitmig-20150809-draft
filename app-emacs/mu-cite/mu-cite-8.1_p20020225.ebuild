# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mu-cite/mu-cite-8.1_p20020225.ebuild,v 1.1 2004/10/22 10:51:23 usata Exp $

inherit elisp

IUSE=""

MY_P="${PN}-200202250931"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Message citation utilities for emacsen"
HOMEPAGE="http://www.jpl.org/elips/mu/"
SRC_URI="http://www.jpl.org/elips/mu/snapshots/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc-macos"

RDEPEND="app-emacs/apel
	virtual/flim"

SITEFILE="50mu-cite-gentoo.el"

src_compile() {
	emake EMACS=emacs || die
}

src_install() {
	elisp_src_install

	dodoc ChangeLog NEWS README.en
}
