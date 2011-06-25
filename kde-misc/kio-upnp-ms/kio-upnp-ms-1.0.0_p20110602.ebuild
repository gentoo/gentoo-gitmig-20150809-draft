# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-upnp-ms/kio-upnp-ms-1.0.0_p20110602.ebuild,v 1.1 2011/06/25 13:23:53 ottxor Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A upnp KIO slave for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-upnp-ms"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="kde-base/kdelibs
	x11-libs/qt-core
	media-libs/herqq"
DEPEND="${RDEPEND}"
