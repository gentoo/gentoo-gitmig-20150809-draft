# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/libydpdict/libydpdict-0.99.3.ebuild,v 1.1 2008/01/23 20:15:47 peper Exp $

DESCRIPTION="Library for handling the Collins Dictionary database."
HOMEPAGE="http://toxygen.net/ydpdict/"
SRC_URI="http://toxygen.net/ydpdict/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS
}
