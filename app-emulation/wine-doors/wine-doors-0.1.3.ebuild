# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine-doors/wine-doors-0.1.3.ebuild,v 1.2 2009/07/13 09:16:17 hanno Exp $

EAPI=2

inherit distutils

DESCRIPTION="Wine-doors is a package manager for wine."
HOMEPAGE="http://www.wine-doors.org"
SRC_URI="http://www.wine-doors.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pycairo
	dev-python/pygtk
	dev-python/librsvg-python
	gnome-base/libglade
	dev-libs/libxml2[python]
	app-pda/orange
	app-arch/cabextract
	app-emulation/wine"
RDEPEND="${DEPEND}
	dev-python/gconf-python"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	distutils_src_install --temp="${D}"
	keepdir /etc/wine-doors
}
