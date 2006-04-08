# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kerry/kerry-0.1-r1.ebuild,v 1.1 2006/04/08 16:47:16 flameeyes Exp $

inherit kde

DESCRIPTION="Kerry Beagle is a KDE frontend for the Beagle desktop search daemon"
HOMEPAGE="http://en.opensuse.org/Kerry"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

SRC_URI="http://developer.kde.org/~binner/kerry/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-misc/beagle-0.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

need-kde 3.4

PATCHES="${FILESDIR}/${P}-ebuilds.patch
	${FILESDIR}/${PN}-0.09-del-shortcut.patch"

