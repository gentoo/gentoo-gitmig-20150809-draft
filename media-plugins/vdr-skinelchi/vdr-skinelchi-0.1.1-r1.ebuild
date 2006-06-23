# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinelchi/vdr-skinelchi-0.1.1-r1.ebuild,v 1.2 2006/06/23 08:55:28 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.vdrportal.de/board/thread.php?threadid=41915&sid="
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22"

PATCHES="${FILESDIR}/${P}-vdr-1.3.38.patch"

