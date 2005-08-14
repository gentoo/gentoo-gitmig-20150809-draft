# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.2.0.ebuild,v 1.1 2005/08/14 21:45:19 humpback Exp $

inherit eutils

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://darcs.0x539.de/gobby"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gnome"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"

DEPEND=">=dev-cpp/glibmm-2.6
	>=dev-cpp/gtkmm-2.6
	>=dev-libs/libsigc++-2.0
	>=net-libs/obby-0.2.0
	>=dev-cpp/libxmlpp-2.6
	>=x11-libs/gtksourceview-1.2.0"

RDEPEND=""

src_compile() {
	econf --with-gtksourceview `use_with gnome` || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	insinto /usr/share/applications
	newins ${FILESDIR}/${PN}.desktop-r1 ${PN}.desktop
}

pkg_postinst() {
	if built_with_use net-libs/obby howl
	then
		einfo "Zeroconf support has been enabled for gobby"
	else
		einfo "net-libs/obby was not build with zeroconf support,"
		einfo "thus	zeroconf is not enabled for ${PN}."
		einfo ""
		einfo "To get zeroconf support, rebuild net-libs/obby"
		einfo "with \"howl\" in your USE flags."
		einfo "Try USE=\"howl\" emerge net-libs/obby app-editors/gobby,"
		einfo "or add \"howl\" to your USE string in /etc/make.conf and"
		einfo "emerge net-libs/obby"
	fi
}
