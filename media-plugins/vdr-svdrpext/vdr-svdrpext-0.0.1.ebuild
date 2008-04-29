# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-svdrpext/vdr-svdrpext-0.0.1.ebuild,v 1.3 2008/04/29 11:46:04 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder svdrpext PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/svdrpext/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"
