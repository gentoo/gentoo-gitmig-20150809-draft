# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mu-cite/mu-cite-8.1_p20020225.ebuild,v 1.5 2007/07/03 09:35:39 opfer Exp $

inherit elisp

MY_P="${PN}-200202250931"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Message citation utilities for emacsen"
HOMEPAGE="http://www.jpl.org/elips/mu/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc-macos ~x86"

RDEPEND="app-emacs/apel
	virtual/flim"
IUSE=""

SITEFILE="50mu-cite-gentoo.el"
DOCS="ChangeLog NEWS README.en"

src_compile() {
	emake EMACS=emacs || die "emake failed"
}
