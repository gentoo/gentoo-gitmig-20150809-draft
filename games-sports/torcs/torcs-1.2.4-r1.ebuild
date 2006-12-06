# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/torcs/torcs-1.2.4-r1.ebuild,v 1.6 2006/12/06 20:22:43 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="The Open Racing Car Simulator"
HOMEPAGE="http://torcs.org/"
SRC_URI="mirror://sourceforge/torcs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.3
	virtual/opengl
	virtual/glut
	media-libs/openal
	media-libs/freealut
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freealut.patch \
		"${FILESDIR}/${P}"-gcc41.patch
	sed -i \
		-e "s:/games::" \
		Make-config.in \
		src/linux/torcs.in \
		src/tools/trackgen/trackgen.in \
		src/tools/nfs2ac/nfs2ac.in \
		src/tools/accc/accc.in \
		src/tools/texmapper/texmapper.in \
		src/tools/nfsperf/nfsperf.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--x-libraries=/usr/lib || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install datainstall || die "make install failed"
	dodoc README.linux
	dohtml *.html *.png
	prepgamesdirs
}
