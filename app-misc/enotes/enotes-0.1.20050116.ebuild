# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/enotes/enotes-0.1.20050116.ebuild,v 1.3 2005/04/11 03:54:50 vapier Exp $

inherit enlightenment

DESCRIPTION="sticky notes system based on the EFL"

DEPEND=">=x11-libs/ewl-0.0.4
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9
	>=media-libs/imlib2-1.2.0
	>=media-libs/edje-0.5.0
	>=dev-db/edb-1.0.5
	dev-libs/libxml2
	>=x11-libs/esmart-0.0.3"
RDEPEND="${DEPEND}
	app-misc/examine"
