# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wikipedia-mode/wikipedia-mode-0.5.ebuild,v 1.3 2008/06/14 23:31:23 ulm Exp $

inherit elisp

DESCRIPTION="Mode for editing Wikipedia articles off-line"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/WikipediaMode"
SRC_URI="http://wwww.flameeyes.eu/gentoo-distfiles/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-emacs/outline-magic"

SITEFILE=50${PN}-gentoo.el
