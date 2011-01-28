# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cinebars/vdr-cinebars-0.0.3a.ebuild,v 1.3 2011/01/28 18:08:52 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Show black bars to hide station logo"
HOMEPAGE="http://www.egal-vdr.de/plugins/"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.3.32"
RDEPEND="${DEPEND}"