# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xf86audio/xmms-xf86audio-0.4.4.ebuild,v 1.1 2006/07/23 15:45:59 metalgod Exp $

DESCRIPTION="XF86Audio for XMMS"
HOMEPAGE="http://www.devin.com/xmms-xf86audio/"
SRC_URI="http://www.devin.com/xmms-xf86audio/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-sound/xmms"

src_compile() {
	emake OPT="${CFLAGS}" || die
}

src_install() {
	einstall PLUGINDIR="${D}`xmms-config --general-plugin-dir`" || die

	dodoc README
}
