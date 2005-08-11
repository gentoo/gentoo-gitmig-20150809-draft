# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/spacearyarya-kxl/spacearyarya-kxl-1.0.2-r1.ebuild,v 1.4 2005/08/11 23:45:01 tester Exp $

inherit eutils games

MY_P=SpaceAryarya-KXL-${PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A 2D/3D shooting game"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${MY_P}.tar.gz"

KEYWORDS="~amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-games/KXL-1.1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	aclocal || die "aclocal failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog README
	prepgamesdirs
}
