# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sawfish/sawfish-1.32.ebuild,v 1.6 2007/10/23 11:56:03 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for Sawfish programs and interaction with the Sawfish window manager"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-wm/sawfish"

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
