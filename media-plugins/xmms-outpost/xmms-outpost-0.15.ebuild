# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-outpost/xmms-outpost-0.15.ebuild,v 1.3 2004/03/29 23:15:02 dholm Exp $

inherit kde
need-kde 3

MY_P=${P/xmms-/}
S=${WORKDIR}/outpost

DEPEND="media-sound/xmms"

DESCRIPTION="XMMS Outpost is an KDE Application embedded into the KDE Systray for controlling XMMS."
SRC_URI="http://axj.tuxipuxi.de/software/${MY_P}.tar.bz2"
HOMEPAGE="http://axj.tuxipuxi.de/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""

SLOT="0"

src_compile() {
	make
}

src_install() {
	exeinto /usr/bin
	doexe outpost

	dodoc README README.de CHANGELOG
}
