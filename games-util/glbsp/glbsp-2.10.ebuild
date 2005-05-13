# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/glbsp/glbsp-2.10.ebuild,v 1.1 2005/05/13 07:00:23 mr_bones_ Exp $

DESCRIPTION="A node builder specially designed for OpenGL ports of the DOOM game engine"
HOMEPAGE="http://glbsp.sourceforge.net/"
SRC_URI="mirror://sourceforge/glbsp/${PN}_src_${PV//.}c.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC=/d' \
		-e "s:-O3:${CFLAGS}:" Plugin.mak Makefile \
		|| die "sed failed"
}

src_compile() {
	emake || die "emake failed"
	emake -f Plugin.mak || die "emake failed"
}

src_install() {
	dobin glbsp || die "dobin failed"
	dolib.a libglbsp.a || die "dolib.a failed"
	dodoc CHANGES.txt README.txt TODO.txt USAGE.txt
}
