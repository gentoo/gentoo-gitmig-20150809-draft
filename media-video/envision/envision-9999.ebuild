# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/envision/envision-9999.ebuild,v 1.2 2005/02/22 23:01:59 vapier Exp $

ECVS_MODULE="misc/envision"
inherit enlightenment

DESCRIPTION="an e17 video player"

DEPEND="media-libs/xine-lib
	x11-libs/ecore
	x11-libs/evas
	media-libs/edje
	>=media-libs/emotion-0.0.1"
