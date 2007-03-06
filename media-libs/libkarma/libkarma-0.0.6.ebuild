# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkarma/libkarma-0.0.6.ebuild,v 1.3 2007/03/06 08:41:48 corsair Exp $

inherit eutils mono multilib

DESCRIPTION="Support library for using Rio devices with mtp"
HOMEPAGE="http://www.freakysoft.de/html/libkarma/"
SRC_URI="http://www.freakysoft.de/html/libkarma/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="virtual/libiconv
	media-libs/taglib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	# need "all" target to build both static and shared libs
	emake -j1 all || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install PREFIX="${D}/usr" || die "emake install failed"
}
