# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ebg/ebg-1.0.0.20031013.ebuild,v 1.3 2004/03/19 07:56:03 mr_bones_ Exp $

inherit enlightenment

DESCRIPTION="Enlightenment Background Library API: create backgrounds with multiple images, boxes, or gradients"

DEPEND="${DEPEND}
	>=x11-libs/evas-1.0.0.20031013_pre12
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=dev-db/edb-1.0.4.20031013
	>=media-libs/imlib2-1.1.0"
