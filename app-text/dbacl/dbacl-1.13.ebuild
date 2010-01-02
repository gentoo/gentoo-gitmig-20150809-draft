# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dbacl/dbacl-1.13.ebuild,v 1.2 2010/01/02 11:10:00 fauli Exp $

inherit eutils

DESCRIPTION="digramic Bayesian text classifier"
HOMEPAGE="http://www.lbreyer.com/gpl.html"
SRC_URI="http://www.lbreyer.com/gpl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~s390 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS ChangeLog
}
