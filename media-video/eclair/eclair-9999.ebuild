# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/eclair/eclair-9999.ebuild,v 1.6 2005/09/06 03:34:09 vapier Exp $

inherit enlightenment

DESCRIPTION="EFL powered media player"

RDEPEND="media-libs/taglib
	x11-libs/evas
	x11-libs/ecore
	media-libs/edje
	media-libs/emotion
	x11-libs/esmart
	dev-libs/libxml2
	>=dev-db/sqlite-3"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.17"
