# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ebuild-mode/ebuild-mode-1.0.ebuild,v 1.2 2006/11/25 10:00:41 flameeyes Exp $

inherit elisp

DESCRIPTION="Automatically generate a menu of available fonts (normally bound to S-mouse-1) constrained by personal preferences."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/KahlilHodgson"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50ebuild-mode-gentoo.el

