# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flashcard/flashcard-2.3.3.ebuild,v 1.1 2007/02/10 22:43:40 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs Lisp package for drilling on questions and answers."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FlashCard"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"

SITEFILE=50flashcard-gentoo.el