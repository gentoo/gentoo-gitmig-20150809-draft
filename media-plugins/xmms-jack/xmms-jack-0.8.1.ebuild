# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.8.1.ebuild,v 1.4 2004/03/26 22:01:53 eradicator Exp $

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="media-sound/xmms
	virtual/jack"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

S="${WORKDIR}/${PN}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
