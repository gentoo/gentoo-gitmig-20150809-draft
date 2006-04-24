# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xplc/xplc-0.3.13-r1.ebuild,v 1.5 2006/04/24 02:36:33 metalgod Exp $

DESCRIPTION="cross platform lightweight components library for C++"
HOMEPAGE="http://xplc.sourceforge.net"
SRC_URI="mirror://sourceforge/xplc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc sparc x86"
IUSE=""

DEPEND="dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	#solve conflict with uuidgen utility installed by sys-fs/e2fsprogs (#116699)
	cd "${S}"
	sed -i -e "s/uuidgen/xplc-uuidgen/g" -e "s/uuidcdef/xplc-uuidcdef/g" \
		uuid/{rules.mk,vars.mk} config/rules.mk \
		uuid/bin/*.1 include/xplc/*.h && \
			mv uuid/bin/uuidgen.1 uuid/bin/xplc-uuidgen.1 &&
			mv uuid/bin/uuidgen.c uuid/bin/xplc-uuidgen.c ||
			die "uuidgen rename failed"
}

src_test() {
	make tests || die "at least one test has failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dosym /usr/lib/pkgconfig/${P}.pc /usr/lib/pkgconfig/${PN}.pc
	dodoc LICENSE README NEWS CREDITS
}
