# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-premiereepg/vdr-premiereepg-0.0.5.ebuild,v 1.1 2006/05/26 22:59:06 hd_brummy Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: The plugin parses the extended EPG data which is send by Premiere on their portal channels"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

PATCHES="${FILESDIR}/libsi_include-${PV}.patch"
