# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/bubblet/bubblet-0.74-r1.ebuild,v 1.3 2007/12/02 23:45:53 opfer Exp $

inherit elisp

DESCRIPTION="A bubble-popping game"
HOMEPAGE="http://www.gelatinous.com/pld/bubblet.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
