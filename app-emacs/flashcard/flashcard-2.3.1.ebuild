# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flashcard/flashcard-2.3.1.ebuild,v 1.1 2005/09/03 09:00:24 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs Lisp package for drilling on questions and answers."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FlashCard"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"

SITEFILE=50flashcard-gentoo.el

# src_compile() {
# 	elisp-comp *.el
# }

# src_install() {
# 	elisp_src_install
# }
