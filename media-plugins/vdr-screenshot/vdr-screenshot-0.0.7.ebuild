# Copyright 2004-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-screenshot/vdr-screenshot-0.0.7.ebuild,v 1.1 2006/02/03 11:15:49 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://www.joachim-wilke.de/vdr.htm"
SRC_URI="http://www.joachim-wilke.de/vdr-${VDRPLUGIN}/${P}.tar.bz2
	mirror://gentoo/${P#vdr-}.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"

src_unpack() {
	vdr-plugin_src_unpack
	epatch ${DISTDIR}/${P#vdr-}.patch
}

