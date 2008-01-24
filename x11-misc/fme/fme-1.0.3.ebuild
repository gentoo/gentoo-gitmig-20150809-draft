# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fme/fme-1.0.3.ebuild,v 1.2 2008/01/24 19:04:45 lack Exp $

inherit eutils

DESCRIPTION="Graphical menu editor for Fluxbox menus"
HOMEPAGE="http://fme.rhymux.info/"
SRC_URI="http://fme.rhymux.info/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-cpp/gtkmm
	dev-libs/boost
	dev-cpp/libglademm
	dev-libs/libsigc++
	dev-cpp/glibmm
	sys-devel/bc"

RDEPEND="${DEPEND}
	>=x11-wm/fluxbox-1.0"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	doicon glade/${PN}.png
	make_desktop_entry ${PN} "Fluxbox Menu Editor" ${PN} "Settings;DesktopSettings"

	dodoc AUTHORS ChangeLog README TODO
}
