# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/glukalka/glukalka-0.90.1.ebuild,v 1.3 2004/06/27 23:04:11 vapier Exp $

# set MY_P to glukalka-0.90-1 instead of original glukalka-0.90.1
MY_P=${PN}-${PV%.*}-${PV##*.}

DESCRIPTION="Emulator of ZX Spectrum 48K/128K and clones"
HOMEPAGE="http://glukalka.sourceforge.net"
SRC_URI="mirror://sourceforge/glukalka/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="x11-libs/openmotif
	virtual/x11
	virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/gcc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:-O20:${CFLAGS}:" \
		-e "s:-O2:${CFLAGS}:" configure || \
			die "sed configure failed"

	sed -i \
		-e "s:\"resources/:\"/usr/share/${PN}/resources/:" \
		-e "s:\"icons/:\"/usr/share/${PN}/icons/:" modifed.c || \
			die "sed modifed.c failed"
}

src_install() {
	dobin glukalka || die
	dodir /usr/share/glukalka
	cp -R resources ${D}/usr/share/glukalka
	cp -R icons ${D}/usr/share/glukalka

	dodoc doc/{changelog,todo,copying}
}
