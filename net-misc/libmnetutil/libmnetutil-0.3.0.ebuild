# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/libmnetutil/libmnetutil-0.3.0.ebuild,v 1.1 2005/06/02 01:15:57 gustavoz Exp $

inherit eutils

IUSE=""
DESCRIPTION="Minisip basic networking library"
HOMEPAGE="http://www.minisip.org/"
SRC_URI="http://www.minisip.org/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="~net-misc/libmutil-0.3.0"


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
