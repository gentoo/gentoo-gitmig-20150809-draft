# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/md5/md5-1.0-r1.ebuild,v 1.7 2005/07/01 19:49:37 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="Emacs Lisp implementation of the MD5 algorithm."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=90md5-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
	mv ${S}/md5.el ${S}/md5-digest.el
}
