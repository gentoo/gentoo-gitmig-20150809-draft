# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-browser/color-browser-0.3.ebuild,v 1.2 2007/10/06 21:12:09 ulm Exp $

inherit elisp eutils

DESCRIPTION="A utility for designing Emacs color themes"
HOMEPAGE="http://www.emacswiki.org/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE=""

DEPEND="app-emacs/color-theme"

SITEFILE=60${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo.patch"
}
