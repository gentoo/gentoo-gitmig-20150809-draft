# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dbacl/dbacl-1.13.ebuild,v 1.4 2012/02/19 10:01:37 steev Exp $

DESCRIPTION="digramic Bayesian text classifier"
HOMEPAGE="http://www.lbreyer.com/gpl.html"
SRC_URI="http://www.lbreyer.com/gpl/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~s390 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS ChangeLog
}
