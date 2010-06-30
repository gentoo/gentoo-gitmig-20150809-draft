# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar-gpl/unrar-gpl-0.0.1_p20080417-r1.ebuild,v 1.1 2010/06/30 21:31:57 hanno Exp $

EAPI=2
inherit autotools

DESCRIPTION="Free rar unpacker for old (pre v3) rar files"
HOMEPAGE="http://home.gna.org/unrar/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
S="${WORKDIR}/${PN/-gpl}"

src_prepare() {
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf --program-suffix="-gpl" || die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README || die "dodoc failed"
}
