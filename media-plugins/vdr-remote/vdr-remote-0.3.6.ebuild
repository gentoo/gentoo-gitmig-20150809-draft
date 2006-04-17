# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remote/vdr-remote-0.3.6.ebuild,v 1.4 2006/04/17 13:37:43 zzam Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR - remote control plugin"
HOMEPAGE="http://www.escape-edv.de/endriss/vdr/"
SRC_URI="http://www.escape-edv.de/endriss/vdr/${P}.tgz"
KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"

