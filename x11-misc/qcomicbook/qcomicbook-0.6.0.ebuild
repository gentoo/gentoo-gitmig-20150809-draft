# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qcomicbook/qcomicbook-0.6.0.ebuild,v 1.1 2010/08/01 10:20:30 hwoarang Exp $

EAPI=2
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="A viewer for comic book archives containing jpeg/png images."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=19509"
SRC_URI="http://qcomicbook.linux-projects.net/releases/qcomicbook-0.6.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

pkg_postinst() {
	elog "For using QComicBook with compressed archives you may want to install:"
	elog "    app-arch/p7zip"
	elog "    app-arch/unace"
	elog "    app-arch/unrar or app-arch/rar"
	elog "    app-arch/unzip"
}
