# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/alt-font-menu/alt-font-menu-0.4.ebuild,v 1.2 2004/06/01 14:09:01 vapier Exp $

inherit elisp

DESCRIPTION="Automatically generate a menu of available fonts (normally bound to S-mouse-1) constrained by personal preferences."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/KahlilHodgson"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE=50alt-font-menu-gentoo.el
