# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-dflowers/xmms-dflowers-1.2.ebuild,v 1.10 2004/06/24 23:38:29 agriffis Exp $

inherit eutils

IUSE=""

MY_P=${PN/xmms-/}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dual Flowers visualization plugin for xmms"
HOMEPAGE="http://www.shell.linux.se/bm/index.php?page=xmmsplugin"
SRC_URI="http://hem.passagen.se/joakime/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=sys-apps/portage-2.0.47-r10
	media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	# patch in DESTDIR support
	epatch ${FILESDIR}/${MY_P}-destdir.patch
}

src_compile() {
	# There is no configure script, but the
	# Makefile does things (mostly) correctly.
	make clean || die
	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING Changes
}

pkg_postinst() {
	einfo "Don't forget to set the skin, plugin might look weird otherwise!"
}
