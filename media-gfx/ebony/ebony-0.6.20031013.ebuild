# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ebony/ebony-0.6.20031013.ebuild,v 1.1 2003/10/14 02:59:27 vapier Exp $

inherit enlightenment

DESCRIPTION="tool that creates special bits called bg.db's"
HOMEPAGE="http://www.enlightenment.org/pages/ebony.html"

DEPEND="${DEPEND}
	>=dev-db/edb-1.0.4.20031013
	>=media-libs/ebg-1.0.0.20031013
	>=media-libs/imlib2-1.1.0
	>=x11-libs/evas-1.0.0.20031013_pre12
	=x11-libs/gtk+-1*
	=dev-libs/glib-1*"
