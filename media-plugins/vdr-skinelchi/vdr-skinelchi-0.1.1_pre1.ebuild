# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinelchi/vdr-skinelchi-0.1.1_pre1.ebuild,v 1.1 2006/07/05 18:06:18 zzam Exp $

inherit vdr-plugin

MY_P=${P/_pre/pre}

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.vdrportal.de/board/thread.php?threadid=41915&sid="
SRC_URI="mirror://gentoo/${MY_P}.tgz http://dev.gentoo.org/~zzam/distfiles/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22"

PATCHES="${FILESDIR}/${P}-vdr-1.3.38.patch"

S="${WORKDIR}/${VDRPLUGIN}-0.1.1"
