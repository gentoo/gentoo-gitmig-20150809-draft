# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/libmutil/libmutil-0.3.0.ebuild,v 1.2 2005/07/30 18:12:13 swegener Exp $

IUSE=""
DESCRIPTION="Minisip basic support library"
HOMEPAGE="http://www.minisip.org/"
SRC_URI="http://www.minisip.org/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/openssl-0.9.6d"

src_install() {
	make DESTDIR="${D}" install || die
}
