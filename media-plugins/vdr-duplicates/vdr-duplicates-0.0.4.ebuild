# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-duplicates/vdr-duplicates-0.0.4.ebuild,v 1.1 2012/03/03 21:45:15 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: show duplicated records"
HOMEPAGE="http://www.tolleri.net/vdr/"
SRC_URI="http://www.tolleri.net/vdr/plugins/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"
