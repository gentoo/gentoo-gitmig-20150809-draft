# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.10.ebuild,v 1.5 2004/11/10 01:24:47 eradicator Exp $

IUSE=""

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="media-sound/xmms
	media-sound/jack-audio-connection-kit"

DOCS="AUTHORS ChangeLog NEWS README"

S="${WORKDIR}/${PN}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
