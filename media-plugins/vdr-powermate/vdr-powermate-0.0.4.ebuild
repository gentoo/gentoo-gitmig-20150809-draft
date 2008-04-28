# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-powermate/vdr-powermate-0.0.4.ebuild,v 1.1 2008/04/28 19:50:43 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Powermate PlugIn"
HOMEPAGE="http://www.powarman.de/"
SRC_URI="http://home.arcor.de/andreas.regel/files/powermate/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/vdr"
DEPEND="${RDEPEND}"
