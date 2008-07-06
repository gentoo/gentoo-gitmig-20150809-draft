# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/paredit/paredit-21_beta20080429.ebuild,v 1.1 2008/07/06 15:36:20 ulm Exp $

inherit elisp

DESCRIPTION="Minor mode for performing structured editing of S-expressions"
HOMEPAGE="http://mumble.net/~campbell/emacs/
	http://www.emacswiki.org/cgi-bin/wiki/ParEdit"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_install() {
	elisp_src_install
	dohtml *.html
}
