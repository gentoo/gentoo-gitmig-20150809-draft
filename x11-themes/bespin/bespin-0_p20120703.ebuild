# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/bespin/bespin-0_p20120703.ebuild,v 1.1 2012/07/04 02:20:21 creffett Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A KDE4 follow-up to Baghira KDE Theme Engine, which resembles Mac OS X"
HOMEPAGE="http://cloudcity.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

src_configure() {
	# these two are no-deps options
	# no need to have them useflaged
	mycmakeargs=(
		-DENABLE_XBAR=ON
		-DENABLE_ARGB=ON
	)

	kde4-base_src_configure
}
