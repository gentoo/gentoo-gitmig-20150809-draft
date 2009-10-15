# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/javascript/javascript-2.2.1.ebuild,v 1.1 2009/10/15 21:42:59 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for editing JavaScript source text"
HOMEPAGE="http://www.brgeight.se/
	http://www.emacswiki.org/emacs/JavaScriptMode"
# taken from http://www.brgeight.se/downloads/emacs/javascript.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
