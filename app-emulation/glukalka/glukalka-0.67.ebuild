# Copyright 1999-2004 Gentoo Technologies, Inc. and Robert Cernansky
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/glukalka/glukalka-0.67.ebuild,v 1.4 2004/03/21 19:23:27 dholm Exp $

DESCRIPTION="Emulator of ZX Spectrum 48K/128K and clones"
HOMEPAGE="http://glukalka.sourceforge.net"
SRC_URI="mirror://sourceforge/glukalka/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/openmotif"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# distributed with a binary
	rm -f glukalka

	sed -i \
		-e "/^CFLAGS/ s:=.*:=\"${CFLAGS}\":" \
		-e "s:-O2:${CFLAGS}:" configure || \
			die "sed configure failed"

	sed -i \
		-e "s:\"resources/:\"/usr/share/${PN}/resources/:" \
		-e "s:\"icons/:\"/usr/share/${PN}/icons/:" modifed.c || \
			die "sed modifed.c failed"
}

src_install() {
	dobin glukalka
	dodir /usr/share/glukalka
	cp -R resources ${D}/usr/share/glukalka
	cp -R icons ${D}/usr/share/glukalka

	dodoc doc/{changelog,todo}
}
