# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-1.0.ebuild,v 1.5 2008/01/09 12:33:59 pclouds Exp $

inherit eutils

DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=dev-cpp/gtkmm-2.6
	=x11-libs/gtksourceview-1*
	app-text/aspell"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall
	dodoc ChangeLog README TODO || die
}
