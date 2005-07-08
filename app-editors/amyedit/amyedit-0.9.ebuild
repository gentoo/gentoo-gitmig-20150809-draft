# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-0.9.ebuild,v 1.2 2005/07/08 16:02:34 dholm Exp $
inherit eutils
DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
DEPEND=">=dev-cpp/gtkmm-2.4.8
	>=x11-libs/gtksourceview-1.0
	app-text/aspell"
S=${WORKDIR}/${P}
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc COPYING Changelog INSTALL README TODO || die
}
