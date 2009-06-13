# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kerry/kerry-0.2.1.ebuild,v 1.6 2009/06/13 12:16:39 tampakrap Exp $

inherit kde

DESCRIPTION="Kerry Beagle is a KDE frontend for the Beagle desktop search daemon"
HOMEPAGE="http://en.opensuse.org/Kerry"
SRC_URI="http://developer.kde.org/~binner/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-misc/beagle-0.2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( =kde-base/kdebase-3.5* =kde-base/libkonq-3.5* )"

need-kde 3.4

PATCHES=( "${FILESDIR}/${P}-libbeagle-0.3.patch" )

src_unpack() {
	kde_src_unpack

	# force regeneration of configure script for the libbeagle patch to work
	rm -f configure
}
