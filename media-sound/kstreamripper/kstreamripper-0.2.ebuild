# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.2.ebuild,v 1.3 2004/10/17 09:50:50 dholm Exp $

IUSE=""

inherit kde-base

need-kde 3.2

DESCRIPTION="KStreamripper - a nice KDE3 frontend to media-sound/streamripper"
HOMEPAGE="http://developer.berlios.de/projects/kstreamripper/"
SRC_URI="http://www.tuxipuxi.de/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
DEPEND=">=media-sound/streamripper-1.32-r2"
