# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-3.5.9.ebuild,v 1.3 2008/05/12 20:01:40 ranger Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE digital camera manager"
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""
DEPEND="media-libs/libgphoto2"

RDEPEND="${DEPEND}"
