# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-4.4.2.ebuild,v 1.1 2010/03/30 19:29:12 spatz Exp $

EAPI="3"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

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
