# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-3.4.3.ebuild,v 1.4 2005/11/25 01:08:12 cryos Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE digital camera manager"
KEYWORDS="amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="media-libs/libgphoto2"
