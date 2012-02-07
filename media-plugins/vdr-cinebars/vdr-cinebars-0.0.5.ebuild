# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cinebars/vdr-cinebars-0.0.5.ebuild,v 1.4 2012/02/07 22:09:17 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Show black bars to hide station logo"
HOMEPAGE="http://www.egal-vdr.de/plugins/"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.32"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}_makefile.diff")
