# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-atmo/vdr-atmo-0.1.3.ebuild,v 1.1 2008/03/24 09:50:54 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin:  Plugin for the Atmolight"
HOMEPAGE="http://www.edener.de/"
SRC_URI="http://www.edener.de/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.5.7"
