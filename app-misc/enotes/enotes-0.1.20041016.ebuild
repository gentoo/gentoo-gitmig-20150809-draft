# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/enotes/enotes-0.1.20041016.ebuild,v 1.1 2004/10/18 14:00:03 vapier Exp $

inherit enlightenment

DESCRIPTION="sticky notes system based on the EFL"

DEPEND=">=x11-libs/ewl-0.0.3.20040207
	>=x11-libs/evas-1.0.0_pre13
	>=x11-libs/ecore-1.0.0_pre7
	>=media-libs/imlib2-1.1.1
	>=media-libs/edje-0.5.0
	>=dev-db/edb-1.0.5
	dev-libs/libxml2
	>=x11-libs/esmart-0.0.2.20040207"
