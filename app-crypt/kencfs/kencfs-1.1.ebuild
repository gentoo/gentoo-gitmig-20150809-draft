# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kencfs/kencfs-1.1.ebuild,v 1.1 2011/09/25 15:17:26 dilfridge Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="GUI frontend for encfs"
HOMEPAGE="http://kde-apps.org/content/show.php?content=134003"
SRC_URI="http://kde-apps.org/CONTENT/content-files/134003-${P}.tar.gz"
IUSE=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="kde-base/kdelibs
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	sys-fs/encfs"

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )
