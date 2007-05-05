# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/javascript/javascript-2.0_beta8.ebuild,v 1.1 2007/05/05 18:32:24 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for editing JavaScript source text"
HOMEPAGE="http://web.comhem.se/~u34308910/emacs.html#javascript"
# taken from http://web.comhem.se/~u34308910/emacs/javascript.el.zip
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
