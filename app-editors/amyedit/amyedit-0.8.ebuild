# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-0.8.ebuild,v 1.2 2005/07/10 01:17:00 swegener Exp $

inherit eutils

DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-cpp/gtkmm-2.4
	>=x11-libs/gtksourceview-1.0
	app-text/aspell"

src_install() {
	einstall
	dodoc COPYING Changelog INSTALL README TODO || die
}
