# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/screenlets/screenlets-0.1.2.ebuild,v 1.1 2009/08/22 19:38:59 lack Exp $

EAPI=2
inherit eutils distutils

DESCRIPTION="Screenlets are small owner-drawn applications"
HOMEPAGE="http://www.screenlets.org"
SRC_URI="http://code.launchpad.net/screenlets/trunk/${PV}/+download/screenlets-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+svg"

RDEPEND="dev-python/dbus-python
	svg? ( dev-python/librsvg-python )
	dev-python/libwnck-python
	dev-python/gnome-keyring-python
	dev-python/pyxdg
	x11-libs/libnotify
	x11-misc/xdg-utils"

S="${WORKDIR}/${PN}"

src_install() {
		distutils_src_install

		insinto /usr/share/desktop-directories
		doins "${S}"/desktop-menu/desktop-directories/Screenlets.directory

	    insinto /usr/share/icons
	    doins "${S}"/desktop-menu/screenlets.svg

		# Insert .desktop files
	    for x in $(find "${S}"/desktop-menu -name "*.desktop"); do
			domenu ${x}
	    done
}
