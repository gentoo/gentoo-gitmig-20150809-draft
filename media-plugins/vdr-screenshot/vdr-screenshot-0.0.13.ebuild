# Copyright 2004-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-screenshot/vdr-screenshot-0.0.13.ebuild,v 1.1 2009/03/15 14:29:49 zzam Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-screenshot"
SRC_URI="http://www.joachim-wilke.de/dl.htm?ct=gz&dir=vdr-screenshot&file=${P}.tar.bz2 -> ${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"
RDEPEND="${DEPEND}"
