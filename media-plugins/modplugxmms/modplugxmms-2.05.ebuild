# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/modplugxmms/modplugxmms-2.05.ebuild,v 1.1 2004/11/11 22:26:34 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="XMMS plugin for MOD-like music files"
SRC_URI="mirror://sourceforge/modplug-xmms/${P}.tar.gz"
HOMEPAGE="http://modplug-xmms.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
#-sparc: 2.05: Bus error when starting playback crashed xmms
KEYWORDS="~amd64 -sparc ~x86"

RDEPEND=">=media-sound/xmms-1.2.5-r1
	>=media-libs/libmodplug-0.7"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	make DESTDIR="${D}" install plugindir=$(xmms-config --input-plugin-dir) || die
	rm ${D}/usr/bin/modplugplay
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	einfo "Open XMMS, go to options->preferences->I/O plugins."
	einfo "If \"MikMod Player\" is listed under \"Input Plugins\", click on"
	einfo "it and UNcheck \"Enable Plugin\"."
	einfo "(If you don't disable MikMod, it will play mods instead of ModPlug.)"
	einfo
	einfo "modplugplay has been removed from this package.  To get it, please"
	einfo "emerge media-sound/modplugplay"
}
