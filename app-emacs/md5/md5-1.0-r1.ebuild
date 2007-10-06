# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/md5/md5-1.0-r1.ebuild,v 1.9 2007/10/06 21:37:58 ulm Exp $

inherit elisp eutils

DESCRIPTION="Emacs Lisp implementation of the MD5 algorithm."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2 RSA-MD5"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gentoo.patch"
	mv "${S}"/md5.el "${S}"/md5-digest.el
}
