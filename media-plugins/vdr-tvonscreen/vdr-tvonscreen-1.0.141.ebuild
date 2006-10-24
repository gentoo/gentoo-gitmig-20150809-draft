# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-tvonscreen/vdr-tvonscreen-1.0.141.ebuild,v 1.1 2006/10/24 20:35:14 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="VDR plugin: Show EPG like a TV guide"
HOMEPAGE="http://www.js-home.org/vdr/tvonscreen"
SRC_URI="http://www.js-home.org/vdr/tvonscreen/${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.4.1"

