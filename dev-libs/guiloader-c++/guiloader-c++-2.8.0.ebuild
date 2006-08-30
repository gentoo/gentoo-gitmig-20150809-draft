# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/guiloader-c++/guiloader-c++-2.8.0.ebuild,v 1.1 2006/08/30 14:27:12 pva Exp $

DESCRIPTION="C++ binding to GuiLoader library"
HOMEPAGE="http://gideon.sourceforge.net"
SRC_URI="mirror://sourceforge/gideon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0
		>=dev-cpp/gtkmm-2.8.0
		>=dev-libs/guiloader-2.8.0"

src_compile() {
	econf || die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS
}
