# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/regress/regress-1.5.0.ebuild,v 1.6 2004/11/01 11:34:56 usata Exp $

inherit elisp eutils

DESCRIPTION="Regression test harness for Emacs Lisp code"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~ppc-macos"
IUSE=""

SITEFILE=50regress-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && epatch ${FILESDIR}/${PV}-regress.el-gentoo.patch
}
