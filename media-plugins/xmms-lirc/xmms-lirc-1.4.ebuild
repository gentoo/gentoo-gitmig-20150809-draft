# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-lirc/xmms-lirc-1.4.ebuild,v 1.1 2004/01/29 06:04:34 raker Exp $

MY_P=${P/xmms-lirc/lirc-xmms-plugin}

DESCRIPTION="LIRC plugin for xmms to control xmms with your favorite remote control."
HOMEPAGE="http://www.lirc.org"
SRC_URI="mirror://sourceforge/lirc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-sound/xmms
	app-misc/lirc
	=x11-libs/gtk+-1.2*"
S=${WORKDIR}/${MY_P}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL lircrc NEWS README
}

pkg_postinst () {
	einfo
	einfo "You have to edit your .lircrc. You can find an example file at"
	einfo "/usr/share/doc/xmms-lirc-${PV}."
	einfo "And take a look at the README there."
	einfo
}
