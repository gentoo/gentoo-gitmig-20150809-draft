# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-3.5.0.ebuild,v 1.6 2006/03/28 04:54:37 agriffis Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE digital camera manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="media-libs/libgphoto2"