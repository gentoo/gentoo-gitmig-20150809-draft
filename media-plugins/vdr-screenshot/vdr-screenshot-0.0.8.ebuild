# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-screenshot/vdr-screenshot-0.0.8.ebuild,v 1.2 2006/04/17 13:36:14 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://joachim-wilke.de/vdr-screenshot.htm"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"

