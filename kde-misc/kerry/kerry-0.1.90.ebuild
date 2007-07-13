# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kerry/kerry-0.1.90.ebuild,v 1.3 2007/07/13 05:55:28 mr_bones_ Exp $

inherit kde

DESCRIPTION="Kerry Beagle is a KDE frontend for the Beagle desktop search daemon"
HOMEPAGE="http://en.opensuse.org/Kerry"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

SRC_URI="http://developer.kde.org/~binner/kerry/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-misc/beagle-0.2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( kde-base/libkonq kde-base/kdebase )"

need-kde 3.4

PATCHES="${FILESDIR}/${PN}-0.09-del-shortcut.patch"
