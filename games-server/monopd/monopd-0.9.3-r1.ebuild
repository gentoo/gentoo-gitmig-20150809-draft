# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.9.3-r1.ebuild,v 1.3 2008/05/10 11:12:08 vapier Exp $

inherit eutils games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="http://unixcode.org/downloads/monopd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=net-libs/libcapsinetwork-0.3.0
	>=sys-libs/libmath++-0.0.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch #218833
	epatch "${FILESDIR}"/${P}-dosfix.patch
	# make the example config better (bug #206740)
	sed -i \
		-e '/gatorhost/s/=.*/=monopd-gator.kde.org/' \
		conf/monopd.conf-dist \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/api/gameboard API AUTHORS ChangeLog NEWS README* TODO
	doinitd "${FILESDIR}"/monopd || die "doinitd failed"
	prepgamesdirs
}
