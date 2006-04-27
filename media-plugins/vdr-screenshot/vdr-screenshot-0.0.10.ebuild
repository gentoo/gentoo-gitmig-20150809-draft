# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-screenshot/vdr-screenshot-0.0.10.ebuild,v 1.2 2006/04/27 20:47:45 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://joachim-wilke.de/vdr-screenshot.htm"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"

