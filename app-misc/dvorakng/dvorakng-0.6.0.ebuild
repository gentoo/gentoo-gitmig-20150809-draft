# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dvorakng/dvorakng-0.6.0.ebuild,v 1.8 2005/01/01 14:59:43 eradicator Exp $

DESCRIPTION="Dvorak typing tutor"
HOMEPAGE="http://freshmeat.net/projects/dvorakng/?topic_id=71%2C861"
SRC_URI="http://www.free.of.pl/n/nopik/${P}rc1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ppc64"
IUSE=""
DEPEND="sys-libs/ncurses"

S=${WORKDIR}/dvorakng

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	dobin dvorakng
	dodoc README TODO
}
