# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki-blog/emacs-wiki-blog-0.4-r1.ebuild,v 1.1 2008/01/08 19:44:11 ulm Exp $

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

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-gentoo.patch"
}
