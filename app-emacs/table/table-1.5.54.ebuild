# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/table/table-1.5.54.ebuild,v 1.4 2006/09/02 14:04:54 blubb Exp $

inherit elisp

DESCRIPTION="Table editor for Emacs"
HOMEPAGE="http://table.sourceforge.net/"
SRC_URI="mirror://sourceforge/table/${P}.el.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""
DEPEND="virtual/emacs"

S="${WORKDIR}/"

SITEFILE=50table-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && mv ${P}.el ${PN}.el
}
