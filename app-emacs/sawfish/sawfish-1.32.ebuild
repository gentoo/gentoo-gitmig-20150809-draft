# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sawfish/sawfish-1.32.ebuild,v 1.5 2007/07/04 06:19:06 ulm Exp $

inherit elisp

DESCRIPTION="Sawfish is an GNU Emacs mode for writing code for the Sawfish window manager with support for a REPL"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/sawfish-mode-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-wm/sawfish"

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}/sawfish-mode-${PV}"

src_unpack() {
	unpack ${A}
	mv "${S}"/sawfish-mode.el "${S}"/sawfish.el
}
