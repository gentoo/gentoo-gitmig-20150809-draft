# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.7.ebuild,v 1.1 2004/02/01 05:56:52 eradicator Exp $

DATE="20040119"

MY_P="${P}-${DATE}"
DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-sound/xmms
	media-sound/jack-audio-connection-kit"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

S="${WORKDIR}/${PN}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
