# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/vis5d+/vis5d+-1.2.1.ebuild,v 1.3 2009/08/12 14:10:16 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="3dimensional weather modeling software"
HOMEPAGE="http://vis5d.sourceforge.net"
SRC_URI="mirror://sourceforge/vis5d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# amd64: Function `vis5d_get_dtx' implicitly converted to pointer at graphics.ogl.c:1355
KEYWORDS="-amd64 x86"
IUSE=""

RDEPEND=">=sci-libs/netcdf-3.5"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-round.patch
}

src_configure() {
	econf \
		--without-mixkit \
		--enable-threads
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS ChangeLog PORTING AUTHORS
}
