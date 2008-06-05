# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-4.0.5.ebuild,v 1.1 2008/06/05 21:04:57 keytoaster Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="media-libs/libgphoto2"
RDEPEND="${DEPEND}"
