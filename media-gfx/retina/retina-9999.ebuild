# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/retina/retina-9999.ebuild,v 1.1 2005/09/07 03:43:05 vapier Exp $

ECVS_MODULE="misc/retina"
inherit enlightenment

DESCRIPTION="Evas powered image viewer"

DEPEND="x11-libs/ecore
	x11-libs/evas
	media-libs/imlib2"
