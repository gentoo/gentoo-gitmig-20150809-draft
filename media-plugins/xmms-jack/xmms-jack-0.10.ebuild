# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.10.ebuild,v 1.2 2004/10/19 23:04:19 eradicator Exp $

IUSE=""

inherit xmms-plugin

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="media-sound/jack-audio-connection-kit"

XMMS_S="${XMMS_WORKDIR}/${PN}"
BMP_S="${BMP_WORKDIR}/${PN}"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

