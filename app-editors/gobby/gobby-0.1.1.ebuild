# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.1.1.ebuild,v 1.1 2005/06/19 14:20:12 humpback Exp $

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gnome"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
DEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-libs/libsigc++-2.0
	>=net-libs/obby-0.1.0
	>=dev-cpp/libxmlpp-2.6
	>=x11-libs/gtksourceview-1.2.0"

src_compile() {
	econf --with-gtksourceview `use_with gnome` || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
