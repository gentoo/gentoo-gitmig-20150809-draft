# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dailystrips/dailystrips-1.0.28-r2.ebuild,v 1.1 2004/12/10 09:02:36 mr_bones_ Exp $

DESCRIPTION="dailystrips automatically downloads your favorite online comics from the web."
HOMEPAGE="http://dailystrips.sourceforge.net/"
SRC_URI="mirror://sourceforge/dailystrips/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE=""

RDEPEND=">=dev-perl/libwww-perl-5.50
	dev-perl/DateTime"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/share/dailystrips/strips.def:/etc/strips.def:" \
		dailystrips \
		|| die "sed dailystrips failed"
}

src_install() {
	dobin dailystrips dailystrips-clean dailystrips-update \
		|| die "dobin failed"
	dodoc BUGS CHANGELOG CONTRIBUTORS README* TODO
	insinto /etc
	doins strips.def || die "doins failed"
}
