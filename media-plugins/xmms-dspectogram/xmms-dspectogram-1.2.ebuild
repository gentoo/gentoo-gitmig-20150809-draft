# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-dspectogram/xmms-dspectogram-1.2.ebuild,v 1.7 2003/09/11 01:19:38 msterret Exp $

MY_P=${PN/xmms-/}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dual spectral histogram visualization plugin for xmms"
SRC_URI="http://hem.passagen.se/joakime/${MY_P}.tar.gz"
HOMEPAGE="http://hem.passagen.se/joakime/linuxapp.html"

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
