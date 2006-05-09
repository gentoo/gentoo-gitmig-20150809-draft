# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-0.3.9.ebuild,v 1.3 2006/05/09 20:16:07 wolf31o2 Exp $

inherit eutils

MY_P="SimGear-${PV/_/-}"
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=media-libs/plib-1.8.4
	|| (
		(
			|| (
				~media-libs/openal-0.0.8
				~media-libs/openal-20051024 )
			media-libs/freealut )
		~media-libs/openal-20050504 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	econf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README* NEWS AUTHORS ChangeLog
}
