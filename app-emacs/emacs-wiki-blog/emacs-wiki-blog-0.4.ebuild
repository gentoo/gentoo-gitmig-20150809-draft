# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki-blog/emacs-wiki-blog-0.4.ebuild,v 1.1 2005/02/17 19:19:57 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="Emacs-Wiki add-on for maintaining a weblog"
HOMEPAGE="http://www.sfu.ca/~gswamina/EmacsWikiBlog.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-emacs/emacs-wiki"

SITEFILE=90emacs-wiki-blog-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}
