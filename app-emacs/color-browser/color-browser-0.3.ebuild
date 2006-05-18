# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-browser/color-browser-0.3.ebuild,v 1.1 2006/05/18 03:18:14 mkennedy Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="A utility for designing Emacs color themes."
HOMEPAGE="http://www.emacswiki.org/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"

DEPEND="app-emacs/color-theme"

SITEFILE=60color-browser-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${PV}-gentoo.patch
}
