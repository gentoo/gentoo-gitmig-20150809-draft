# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.3.0.007.ebuild,v 1.2 2007/01/04 06:08:38 vapier Exp $

inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND="media-libs/edje
	x11-libs/ecore
	x11-libs/evas
	>=media-libs/imlib2-1.2.0
	>=media-libs/epeg-0.9.0
	media-libs/libpng"
