# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuninameslist/libuninameslist-20030713.ebuild,v 1.13 2007/01/11 13:42:03 drizzt Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Library of unicode annotation data"
SRC_URI="mirror://sourceforge/libuninameslist/${PN}_src-${PV:2:6}.tgz"
HOMEPAGE="http://libuninameslist.sourceforge.net/"

RESTRICT="nomirror"
LICENSE="BSD"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc-macos ppc64 sparc x86 ~x86-fbsd"
DEPEND=""
RDEPEND=""
IUSE=""

src_compile () {
	econf || die
	emake || die
}


src_install() {
	einstall || die
}
