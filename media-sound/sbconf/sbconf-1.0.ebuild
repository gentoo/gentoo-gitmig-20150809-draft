# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sbconf/sbconf-1.0.ebuild,v 1.3 2004/04/01 07:57:10 eradicator Exp $

inherit gnome2 eutils

DESCRIPTION="Sbconf is a GUI of emu-tools which is a tools to configure your soundblaster card"
HOMEPAGE="http://w3.enternet.hu/televeny/sbconf/sbconf.html"
SRC_URI="http://w3.enternet.hu/televeny/sbconf/${PN}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S=${WORKDIR}/${PN}
IUSE=""
DEPEND="
	>=x11-libs/gtk+-2.0.0
	media-sound/emu10k1
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libglade-2.0.0"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/sbconf-gentoo-path.diff
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
}

