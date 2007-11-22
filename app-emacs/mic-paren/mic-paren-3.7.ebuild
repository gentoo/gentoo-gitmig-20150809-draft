# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mic-paren/mic-paren-3.7.ebuild,v 1.3 2007/11/22 07:26:56 opfer Exp $

inherit elisp

DESCRIPTION="Advanced highlighting of matching parentheses"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/MicParen
	http://user.it.uu.se/~mic/emacs.shtml"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
