# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/glbsp/glbsp-2.05.ebuild,v 1.1 2004/07/21 03:02:05 vapier Exp $

DESCRIPTION="A node builder specially designed for OpenGL ports of the DOOM game engine"
HOMEPAGE="http://glbsp.sourceforge.net/"
SRC_URI="mirror://sourceforge/glbsp/${PN}_src_205.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O3:${CFLAGS}:" {cmdline,plugin}/makefile.unx || die
}

src_compile() {
	emake -C cmdline -f makefile.unx || die "cmdline failed"
	emake -C plugin -f makefile.unx || die "plugin failed"
}

src_install() {
	dobin cmdline/glbsp || die
	dolib.a plugin/libglbsp.a || die
	dodoc CHANGES.txt README.txt TODO.txt USAGE.txt
}
