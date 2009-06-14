# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-avards/vdr-avards-0.1.5.ebuild,v 1.3 2009/06/14 21:50:05 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin:  Automatic Video Aspect Ratio Detection and Signaling"
HOMEPAGE="http://firefly.vdr-developer.org/avards/"
SRC_URI="http://firefly.vdr-developer.org/avards/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"
RDEPEND="${DEPEND}"
