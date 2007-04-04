# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mbuffer/mbuffer-20050730.ebuild,v 1.2 2007/04/04 15:34:05 armin76 Exp $

inherit eutils

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality"
HOMEPAGE="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/"
SRC_URI="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug ssl"

RDEPEND="ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-20050321-configure.patch
}

src_compile() {
	econf \
		$(use_enable ssl md5) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
