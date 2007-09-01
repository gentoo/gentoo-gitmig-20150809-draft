# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-0.14.0.ebuild,v 1.4 2007/09/01 10:30:12 angelos Exp $

DESCRIPTION="A library handling connection to a MPD server."
HOMEPAGE="http://sarine.nl/libmpd"
SRC_URI="http://download.sarine.nl/gmpc-0.15.0/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
