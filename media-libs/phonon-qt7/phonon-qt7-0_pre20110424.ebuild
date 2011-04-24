# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-qt7/phonon-qt7-0_pre20110424.ebuild,v 1.1 2011/04/24 18:45:38 dilfridge Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Phonon QuickTime7 backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-quicktime"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND=">=media-libs/phonon-4.5"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

# needs OpenGL, how do I specify this properly?

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-noshow.patch" )
