# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/regress/regress-1.5.1.ebuild,v 1.1 2005/06/30 15:17:18 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="Regression test harness for Emacs Lisp code"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc ~alpha"
IUSE=""

SITEFILE=50regress-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-regress.el-gentoo.patch
}
