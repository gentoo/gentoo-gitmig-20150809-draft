# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-lirc/bmp-lirc-0.2.2.ebuild,v 1.1 2005/03/19 18:13:28 chainsaw Exp $

MY_P=${P/lirc/extra-plugins}
S=${WORKDIR}/${MY_P}/general/lirc
DESCRIPTION="BMP infra-red remote control support through LIRC."
HOMEPAGE="http://www.sosdg.org/~larne/w/Plugin_list"
SRC_URI="http://www.t17.ikarnet.pl/~wiget/bmp-extra-plugins/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-sound/beep-media-player-0.9.7
	app-misc/lirc"

src_compile() {
	cd ${WORKDIR}/${MY_P}
	econf || die
	cd ${S}
	emake
}

src_install() {
	make DESTDIR=${D} install || die
}
