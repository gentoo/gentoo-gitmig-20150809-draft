# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.102.ebuild,v 1.1 2003/06/13 15:02:01 agriffis Exp $

inherit gnome2

DESCRIPTION="PDF viewer for Gnome 2"
HOMEPAGE="http://www.purl.org/NET/gpdf"

IUSE=""
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="-*"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libgnomeprint-2.2"

# These are required by xpdf so I imagine they're also required by
# gpdf which is based on xpdf.
RDEPEND="${RDEPEND}
	app-text/ghostscript
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOC="AUTHORS ChangeLog COPYING* MAINTAINERS TODO NEWS README"

# This is required to build on alpha but it doesn't actually RUN there
# yet.
use alpha && append-flags -fPIC
