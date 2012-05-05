# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fme/fme-1.1.0.ebuild,v 1.4 2012/05/05 04:53:49 jdhore Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Graphical menu editor for Fluxbox menus"
HOMEPAGE="http://fme.rhymux.info/"
SRC_URI="http://fme.rhymux.info/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/bc
	>=x11-wm/fluxbox-1.0
	>=dev-cpp/gtkmm-2.4:2.4
	>=dev-cpp/glibmm-2.14.0:2
	>=dev-cpp/libglademm-2.4:2.4"

DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	doicon glade/${PN}.png
	make_desktop_entry ${PN} "Fluxbox Menu Editor" ${PN} "Settings;DesktopSettings"

	dodoc AUTHORS ChangeLog README TODO
}
