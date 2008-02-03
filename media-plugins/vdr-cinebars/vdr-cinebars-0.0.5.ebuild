# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cinebars/vdr-cinebars-0.0.5.ebuild,v 1.1 2008/02/03 18:36:06 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="vdr Plugin: Show black bars to hide station logo"
HOMEPAGE="http://www.egal-vdr.de/plugins/"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.32"
