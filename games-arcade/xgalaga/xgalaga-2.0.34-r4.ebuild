# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xgalaga/xgalaga-2.0.34-r4.ebuild,v 1.1 2003/09/10 19:29:22 vapier Exp $

inherit eutils

DESCRIPTION="Galaga game clone."
HOMEPAGE="http://rumsey.org/xgal.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}-27.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${WORKDIR}/${PN}_${PV}-27.diff"
}

src_compile() {
	econf --prefix=/usr/share/xgalaga --bindir=/usr/bin
	emake CPPFLAGS="-D__NO_STRING_INLINES" || die "compile problem"
}

src_install () {
	dobin xgalaga
	dodoc README README.SOUND CHANGES COPYING INSTALL

	insinto /usr/share/xgalaga/sounds
	doins sounds/*.raw

	insinto /usr/share/xgalaga/levels
	doins levels/*.xgl

	exeinto /usr/share/xgalaga
	doexe xgal.sndsrv.linux

	touch "${D}/usr/share/xgalaga/scores"
	fperms 660 /usr/share/xgalaga/scores
	fowners games:games /usr/share/xgalaga/scores
}
