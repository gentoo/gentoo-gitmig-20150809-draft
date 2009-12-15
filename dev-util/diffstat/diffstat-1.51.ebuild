# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.51.ebuild,v 1.9 2009/12/15 18:50:25 armin76 Exp $

DESCRIPTION="Display a histogram of diff changes"
HOMEPAGE="http://invisible-island.net/diffstat/diffstat.html"
SRC_URI="ftp://invisible-island.net/diffstat/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES || die "dodoc failed"
}
