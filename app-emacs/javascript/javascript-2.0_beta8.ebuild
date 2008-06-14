# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/javascript/javascript-2.0_beta8.ebuild,v 1.5 2008/06/14 23:26:59 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for editing JavaScript source text"
HOMEPAGE="http://web.comhem.se/~u34308910/emacs.html#javascript"
# taken from http://web.comhem.se/~u34308910/emacs/javascript.el.zip
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

SITEFILE=50${PN}-gentoo.el
