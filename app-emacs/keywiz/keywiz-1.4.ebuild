# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/keywiz/keywiz-1.4.ebuild,v 1.2 2004/09/03 01:04:53 dholm Exp $

inherit elisp eutils

DESCRIPTION="Emacs key sequence quiz"
HOMEPAGE="http://www.ifa.au.dk/~harder/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50keywiz-gentoo.el
