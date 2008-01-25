# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki-blog/emacs-wiki-blog-0.5.ebuild,v 1.1 2008/01/25 23:01:06 opfer Exp $

inherit elisp eutils

DESCRIPTION="Emacs-Wiki add-on for maintaining a weblog"
HOMEPAGE="http://www.sfu.ca/~gswamina/EmacsWikiBlog.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-emacs/emacs-wiki"
RDEPEND="${DEPEND}"

SITEFILE=90${PN}-gentoo.el
