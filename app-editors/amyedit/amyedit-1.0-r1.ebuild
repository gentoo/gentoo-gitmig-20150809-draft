# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-1.0-r1.ebuild,v 1.6 2008/11/22 15:10:19 maekke Exp $

inherit eutils autotools

DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
RDEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-cpp/glibmm-2.14
	>=dev-libs/libsigc++-2.2
	=x11-libs/gtksourceview-1*
	app-text/aspell"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-keyfile.patch"
	epatch "${FILESDIR}/${P}-signal.patch"
	eautoreconf
}

src_install() {
	einstall
	dodoc ChangeLog README TODO || die
}
