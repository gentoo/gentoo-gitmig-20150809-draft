# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.4.0.ebuild,v 1.1 2010/04/11 15:15:16 scarabeus Exp $

EAPI=2
KDE_LINGUAS="da de en_GB ru tr"
inherit kde4-base

DESCRIPTION="A simple touchpad management service for KDE"
HOMEPAGE="http://synaptiks.lunaryorn.de/"
SRC_URI="http://bitbucket.org/lunar/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="x11-libs/libXi"

DOCS="CHANGES README"

src_configure() {
	if has_version ">=x11-libs/libXi-1.3"; then
		mycmakeargs+=( -DHAVE_XINPUT2=ON )
	fi

	kde4-base_src_configure
}
