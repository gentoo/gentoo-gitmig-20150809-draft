# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xf86audio/xmms-xf86audio-0.4.2.ebuild,v 1.2 2005/07/25 11:50:55 dholm Exp $

DESCRIPTION="XF86Audio for XMMS"
HOMEPAGE="http://www.devin.com/xmms-xf86audio/"
SRC_URI="http://www.devin.com/xmms-xf86audio/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="media-sound/xmms"

src_compile() {
	emake OPT="${CFLAGS}" || die
}

src_install() {
	einstall PLUGINDIR="${D}`xmms-config --general-plugin-dir`" || die

	dodoc README
}
