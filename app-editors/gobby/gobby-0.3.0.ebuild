# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.3.0.ebuild,v 1.5 2007/08/18 23:06:42 dev-zero Exp $

inherit eutils

#MY_P=${P/_rc/rc}
#S=${WORKDIR}/${MY_P}

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://darcs.0x539.de/gobby"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="gnome"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"

DEPEND=">=dev-cpp/glibmm-2.6
	>=dev-cpp/gtkmm-2.6
	>=dev-libs/libsigc++-2.0
	>=net-libs/obby-0.3.0
	>=dev-cpp/libxmlpp-2.6
	>=x11-libs/gtksourceview-1.2.0
	dev-libs/gmp"

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
		elog "Zeroconf support has been enabled for gobby"
	else
		elog "net-libs/obby was not build with zeroconf support,"
		elog "thus	zeroconf is not enabled for ${PN}."
		elog
		elog "To get zeroconf support, rebuild net-libs/obby"
		elog "with \"howl\" in your USE flags."
		elog "Try USE=\"howl\" emerge net-libs/obby app-editors/gobby,"
		elog "or add \"howl\" to your USE string in /etc/make.conf and"
		elog "emerge net-libs/obby"
	fi
}
