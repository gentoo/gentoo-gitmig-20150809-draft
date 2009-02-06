# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-1.36.59.ebuild,v 1.10 2009/02/06 03:11:29 jer Exp $

inherit libtool eutils

IUSE=""
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://critical.ch/distfiles/"
SRC_URI="http://critical.ch/distfiles/${P}.tgz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc43.patch" || die "epatch failed"

	# Needed to get a sane .so versionning on fbsd, please don't drop
	elibtoolize
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS DEVELOPER INSTALL || die
}
