# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/develock/develock-0.35.ebuild,v 1.1 2008/01/25 12:01:51 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs minor mode for highlighting broken formatting rules"
HOMEPAGE="http://www.jpl.org/ftp/pub/elisp/"
SRC_URI="mirror://gentoo/${P}.el.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~amd64 ~ppc ~x86"

IUSE=""

DEPEND=""

SIMPLE_ELISP="t"
SITEFILE=50develock-gentoo.el
