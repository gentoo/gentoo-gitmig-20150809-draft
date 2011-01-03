# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.4.0-r1.ebuild,v 1.1 2011/01/03 18:56:57 dilfridge Exp $

EAPI=2
KDE_LINGUAS="cs da de es ga lt nds pt pt_BR ru sv uk"
inherit kde4-base

DESCRIPTION="Simple touchpad management service for KDE"
HOMEPAGE="http://synaptiks.lunaryorn.de/"
SRC_URI="http://bitbucket.org/lunar/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="x11-libs/libXi"

PATCHES=( "${FILESDIR}/${P}"-kcmdesktop.patch )

src_configure() {
	if has_version ">=x11-libs/libXi-1.3"; then
		mycmakeargs+=( -DHAVE_XINPUT2=ON )
	fi

	kde4-base_src_configure
}
