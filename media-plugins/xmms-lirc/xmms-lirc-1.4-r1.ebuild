# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-lirc/xmms-lirc-1.4-r1.ebuild,v 1.1 2004/10/20 10:06:36 eradicator Exp $

IUSE=""

inherit xmms-plugin

MY_P=${P/xmms-lirc/lirc-xmms-plugin}
XMMS_S=${XMMS_WORKDIR}/${MY_P}
BMP_S=${BMP_WORKDIR}/${MY_P}

DESCRIPTION="LIRC plugin for xmms to control xmms with your favorite remote control."
HOMEPAGE="http://www.lirc.org"
SRC_URI="mirror://sourceforge/lirc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-misc/lirc"

DOCS="AUTHORS ChangeLog lircrc NEWS README"

pkg_postinst () {
	einfo
	einfo "You have to edit your .lircrc. You can find an example file at"
	einfo "/usr/share/doc/xmms-lirc-${PF}."
	einfo "And take a look at the README there."
	einfo
}
