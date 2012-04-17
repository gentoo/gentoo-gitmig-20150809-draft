# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.4.0-r1.ebuild,v 1.5 2012/04/17 15:08:44 mgorny Exp $

EAPI=3
KDE_LINGUAS="cs da de es ga lt nds pt pt_BR ru sv uk"
inherit kde4-base

DESCRIPTION="Simple touchpad management service for KDE"
HOMEPAGE="http://synaptiks.readthedocs.org"
SRC_URI="mirror://bitbucket/lunar/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug +handbook"

DEPEND=">=x11-libs/libXi-1.3"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}"-kcmdesktop.patch )

src_configure() {
	local mycmakeargs+=( -DHAVE_XINPUT2=ON )

	kde4-base_src_configure
}
