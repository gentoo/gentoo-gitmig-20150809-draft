# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rst-mode/rst-mode-0.2.9.ebuild,v 1.1 2006/11/06 06:37:51 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="A major mode for editing reStructuredText"
HOMEPAGE="http://www.merten-home.de/FreeSoftware/rst-mode/index.html
	http://www.emacswiki.org/cgi-bin/wiki/reStructuredText"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

SITEFILE="50${PN}-gentoo.el"
