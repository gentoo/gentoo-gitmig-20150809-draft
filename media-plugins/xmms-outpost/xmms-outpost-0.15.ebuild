# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-outpost/xmms-outpost-0.15.ebuild,v 1.9 2004/09/14 07:08:55 eradicator Exp $

IUSE=""

inherit kde eutils

MY_P=${P/xmms-/}
S=${WORKDIR}/outpost

DESCRIPTION="XMMS Outpost is an KDE Application embedded into the KDE Systray for controlling XMMS."
SRC_URI="http://axj.tuxipuxi.de/software/${MY_P}.tar.bz2"
HOMEPAGE="http://axj.tuxipuxi.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc"

DEPEND="media-sound/xmms"
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	exeinto /usr/bin
	doexe outpost

	dodoc README README.de CHANGELOG
}
