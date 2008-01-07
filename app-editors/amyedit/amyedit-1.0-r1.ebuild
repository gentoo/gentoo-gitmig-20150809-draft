# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-1.0-r1.ebuild,v 1.1 2008/01/07 14:18:52 pclouds Exp $

inherit eutils

DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-cpp/glibmm-2.14
	=x11-libs/gtksourceview-1*
	app-text/aspell"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-keyfile.patch"
}

src_install() {
	einstall
	dodoc ChangeLog README TODO || die
}
