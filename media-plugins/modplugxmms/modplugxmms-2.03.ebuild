# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/modplugxmms/modplugxmms-2.03.ebuild,v 1.8 2004/07/14 20:40:52 agriffis Exp $

IUSE=""

DESCRIPTION="XMMS plugin for MOD-like music files"
SRC_URI="mirror://sourceforge/modplug-xmms/${P}.tar.gz"
HOMEPAGE="http://modplug-xmms.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-sound/xmms-1.2.5-r1"

src_install () {
	einstall \
		plugindir=${D}/usr/lib/xmms/Input || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

pkg_postinst() {
	einfo "Open XMMS, go to options->preferences->I/O plugins."
	einfo "If \"MikMod Player\" is listed under \"Input Plugins\", click on"
	einfo "it and UNcheck \"Enable Plugin\"."
	einfo "(If you don't disable MikMod, it will play mods instead of ModPlug.)"
}
