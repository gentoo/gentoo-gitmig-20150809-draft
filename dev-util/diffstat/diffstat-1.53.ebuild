# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.53.ebuild,v 1.7 2011/01/29 17:41:23 armin76 Exp $

DESCRIPTION="Display a histogram of diff changes"
HOMEPAGE="http://invisible-island.net/diffstat/diffstat.html"
SRC_URI="ftp://invisible-island.net/diffstat/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES || die "dodoc failed"
}
