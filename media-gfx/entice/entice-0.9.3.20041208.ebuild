# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/entice/entice-0.9.3.20041208.ebuild,v 1.1 2004/12/10 16:31:58 vapier Exp $

inherit enlightenment

DESCRIPTION="the E image browser"
HOMEPAGE="http://www.enlightenment.org/pages/entice.html"

DEPEND=">=media-libs/imlib2-1.1.2.20041031
	>=x11-libs/evas-1.0.0.20041031_pre13
	>=dev-db/edb-1.0.5.20041031
	>=x11-libs/ecore-1.0.0.20041031_pre7
	>=x11-libs/esmart-0.9.0.20041031
	>=media-libs/edje-0.5.0.20041031"
