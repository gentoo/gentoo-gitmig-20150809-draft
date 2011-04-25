# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-qt7/phonon-qt7-0_pre20110424.ebuild,v 1.2 2011/04/25 14:45:44 grobian Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Phonon QuickTime7 backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-quicktime"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~ppc-macos"
SLOT="0"
IUSE="debug"

RDEPEND=">=media-libs/phonon-4.5"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
	media-libs/opengl-apple
	sys-devel/gcc-apple[objc]
"

# needs OpenGL, how do I specify this properly?
# I just depended on opengl-apple, hope this is what you meant -- grobian

S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/${PN}-noshow.patch"
	"${FILESDIR}"/${P}-QWidget-cast-dynamic.patch
)
