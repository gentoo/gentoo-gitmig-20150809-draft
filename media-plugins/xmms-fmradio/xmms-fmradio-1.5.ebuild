# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fmradio/xmms-fmradio-1.5.ebuild,v 1.2 2003/04/25 14:14:13 vapier Exp $

MY_P=${P/fmr/FMR}
S=${WORKDIR}/${MY_P}
DESCRIPTION="radio tuner Plugin for XMMS"
HOMEPAGE="http://silicone.free.fr/xmms-FMRadio/"
SRC_URI="http://silicone.free.fr/xmms-FMRadio/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="media-sound/xmms"

src_compile() {
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die
	dodoc INSTALL README
}
