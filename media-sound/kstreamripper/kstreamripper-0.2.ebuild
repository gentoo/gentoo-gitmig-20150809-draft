# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.2.ebuild,v 1.5 2004/11/23 05:50:32 eradicator Exp $

IUSE=""

inherit kde-base

need-kde 3.2

DESCRIPTION="KStreamripper - a nice KDE3 frontend to media-sound/streamripper"
HOMEPAGE="http://developer.berlios.de/projects/kstreamripper/"
SRC_URI="http://www.tuxipuxi.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/streamripper-1.32-r2"
