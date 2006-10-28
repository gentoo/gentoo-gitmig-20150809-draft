# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/mergelog/mergelog-4.5.ebuild,v 1.3 2006/10/28 11:03:32 tomk Exp $

DESCRIPTION="A utility to merge apache logs in chronological order"
SRC_URI="mirror://sourceforge/mergelog/${P}.tar.gz"
HOMEPAGE="http://mergelog.sourceforge.net"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~amd64"

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	econf || die "configure failed"
	emake  || die "make failed"
}

src_install() {
	einstall
	dobin src/mergelog src/zmergelog

	doman man/*.1
	dodoc AUTHORS COPYING README
}
