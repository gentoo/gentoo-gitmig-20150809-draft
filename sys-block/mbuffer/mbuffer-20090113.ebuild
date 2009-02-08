# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mbuffer/mbuffer-20090113.ebuild,v 1.1 2009/02/08 19:50:37 vapier Exp $

inherit eutils autotools

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality"
HOMEPAGE="http://www.maier-komor.de/mbuffer.html"
SRC_URI="http://www.maier-komor.de/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug ssl"

RDEPEND="ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
		$(use_enable ssl md5) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
