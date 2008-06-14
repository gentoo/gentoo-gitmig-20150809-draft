# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/df-mode/df-mode-20050509.ebuild,v 1.4 2008/06/14 23:25:16 ulm Exp $

inherit elisp

DESCRIPTION="Minor mode to show space left on devices in the mode line"
HOMEPAGE="http://www.coli.uni-saarland.de/~fouvry/software.html
	http://www.emacswiki.org/cgi-bin/wiki/DfMode"
# taken from http://www.coli.uni-saarland.de/~fouvry/files/df-mode.el.gz
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

pkg_postinst() {
	einfo "If you are updating from df-1.5: The user interface for df-mode"
	einfo "has changed. See <http://www.emacswiki.org/cgi-bin/wiki/DfMode>"
	einfo "for documentation."
}
