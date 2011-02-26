# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kosd/kosd-0.6.2.ebuild,v 1.1 2011/02/26 20:38:31 dilfridge Exp $

EAPI=3
KDE_MINIMAL=4.6
inherit kde4-base

DESCRIPTION="KDE application that runs in the background and responds to button presses by showing a tiny OSD"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KOSD?content=81457"
SRC_URI="http://kde-apps.org/CONTENT/content-files/81457-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND="
	$(add_kdebase_dep solid)
	$(add_kdebase_dep kmix)
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinstall
	elog Since version 0.5 kosd is a Plasma-based kded plugin and can be
	elog configured in the systemsettings dialog \"Shortcuts and Gestures\".
}
