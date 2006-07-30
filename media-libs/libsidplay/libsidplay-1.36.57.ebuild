# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-1.36.57.ebuild,v 1.15 2006/07/30 22:03:52 tgall Exp $

inherit eutils

IUSE=""
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/linux.html"
SRC_URI="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/packages/${P}.tgz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libsidplay-gcc34.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING DEVELOPER INSTALL
}
