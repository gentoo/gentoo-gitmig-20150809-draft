# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/entice/entice-0.9.0.20040110.ebuild,v 1.1 2004/01/11 22:29:56 vapier Exp $

inherit enlightenment

DESCRIPTION="the E image browser"
HOMEPAGE="http://www.enlightenment.org/pages/entice.html"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.1.0
	>=x11-libs/evas-1.0.0.20031025_pre12
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/ecore-1.0.0.20031213_pre4
	>=x11-libs/esmart-0.0.2.20031025
	>=media-libs/edje-0.0.1.20031020"
