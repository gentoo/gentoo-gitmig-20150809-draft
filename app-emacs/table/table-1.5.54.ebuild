# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/table/table-1.5.54.ebuild,v 1.1 2005/02/01 08:10:52 mkennedy Exp $

inherit elisp

DESCRIPTION="Table editor for Emacs"
HOMEPAGE="http://table.sourceforge.net/"
SRC_URI="mirror://sourceforge/table/${P}.el.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""
DEPEND="virtual/emacs"

S="${WORKDIR}/"

SITEFILE=50table-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && mv ${P}.el ${PN}.el
}
