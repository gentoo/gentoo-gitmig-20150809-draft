# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/cjkuni-fonts/cjkuni-fonts-0.0.20050501.ebuild,v 1.3 2005/08/23 14:44:52 gustavoz Exp $

inherit font

MY_PV=${PV}-1
DESCRIPTION="Full sized CJK unicode truetype fontset"
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fCJKUnifonts"
SRC_URI="http://debian.linux.org.tw/pub/3Anoppix/people/arne/uming/ttf-arphic-uming_${MY_PV}.tar.gz
	http://debian.linux.org.tw/pub/3Anoppix/people/arne/ukai/ttf-arphic-ukai_${MY_PV}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

S=${WORKDIR}

src_install () {
	insinto "/usr/share/fonts/${PN}"

	cd ${S}/ttf-arphic-uming-${PV}
	doins uming.ttf
	mv README README.uming
	dodoc README.uming

	cd ${S}/ttf-arphic-ukai-${PV}
	doins ukai.ttf
	mv README README.ukai
	dodoc README.ukai

	font_xfont_config
	font_xft_config
}
