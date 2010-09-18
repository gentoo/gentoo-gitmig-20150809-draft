# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cfe/cfe-0.12.ebuild,v 1.5 2010/09/18 05:49:29 dirtyepic Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="Console font editor"
# the homepage is missing, so if you find new location please let us know
HOMEPAGE="http://lrn.ru/~osgene/"
SRC_URI="http://download.uhulinux.hu/pub/pub/mirror/http:/lrn.ru/~osgene/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch

	# Remove unconditional assignment of CFLAGS
	sed -i -e '/GCC = yes/d' configure.in
	eautoreconf
}

src_install() {
	dobin cfe || die "dobin cfe failed"
	doman cfe.1
	dodoc ChangeLog INSTALL THANKS dummy.fnt
}
