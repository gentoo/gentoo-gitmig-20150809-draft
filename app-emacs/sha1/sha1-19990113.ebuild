# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sha1/sha1-19990113.ebuild,v 1.4 2004/06/30 02:45:25 agriffis Exp $

inherit elisp

DESCRIPTION="Emacs Lisp implementation of the SHA1 algorithm."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE=50sha1-gentoo.el
