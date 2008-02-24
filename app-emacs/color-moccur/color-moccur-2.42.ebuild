# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-moccur/color-moccur-2.42.ebuild,v 1.1 2008/02/24 13:29:02 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for color moccur"
HOMEPAGE="http://www.bookshelf.jp/
	http://www.emacswiki.org/cgi-bin/wiki/SearchBuffers"
# taken from http://www.bookshelf.jp/elc/color-moccur.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE="50${PN}-gentoo.el"
