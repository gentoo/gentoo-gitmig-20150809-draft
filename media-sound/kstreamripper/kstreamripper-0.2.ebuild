# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.2.ebuild,v 1.1 2004/09/16 20:28:01 eradicator Exp $

IUSE=""

inherit kde-base

need-kde 3.2

S="${WORKDIR}/${P}"
DESCRIPTION="KStreamripper - a nice KDE3 frontend to media-sound/streamripper"
HOMEPAGE="http://developer.berlios.de/projects/kstreamripper/"
SRC_URI="http://www.tuxipuxi.de/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
DEPEND=">=media-sound/streamripper-1.32-r2"
