# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-4.8.1.ebuild,v 1.2 2012/04/04 16:56:46 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE digital camera manager"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"
