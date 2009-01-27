# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-4.2.0.ebuild,v 1.1 2009/01/27 16:33:38 alexxy Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="media-libs/libgphoto2"
RDEPEND="${DEPEND}"
