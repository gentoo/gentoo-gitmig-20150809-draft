# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dailystrips/dailystrips-1.0.28.ebuild,v 1.2 2003/09/04 04:19:08 msterret Exp $

DESCRIPTION="dailystrips automatically downloads your favorite online comics from the web."
HOMEPAGE="http://dailystrips.sourceforge.net/"
SRC_URI="mirror://sourceforge/dailystrips/${P}.tar.gz"

KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=dev-perl/libwww-perl-5.50"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/share/dailystrips/strips.def:/etc/strips.def:" \
		dailystrips || die "sed dailystrips failed"
}

src_install() {
	dobin dailystrips
	dobin dailystrips-clean
	dodoc README BUGS CHANGELOG TODO

	insinto /etc
	doins strips.def
}
