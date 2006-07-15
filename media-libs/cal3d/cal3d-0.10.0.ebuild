# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cal3d/cal3d-0.10.0.ebuild,v 1.6 2006/07/15 18:57:15 kloeri Exp $

inherit eutils autotools

DESCRIPTION="skeletal based character animation library"
HOMEPAGE="http://home.gna.org/cal3d/"
SRC_URI="http://download.gna.org/cal3d/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="!>=media-libs/cal3d-0.11"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
