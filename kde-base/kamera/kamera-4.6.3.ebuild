# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-4.6.3.ebuild,v 1.2 2011/06/08 22:51:55 tomka Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kcontrol/${PN}
		"
	fi

	kde4-meta_src_unpack
}
