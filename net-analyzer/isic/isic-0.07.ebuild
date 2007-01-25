# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/isic/isic-0.07.ebuild,v 1.1 2007/01/25 17:37:32 vanquirius Exp $

inherit eutils

DESCRIPTION="IP Stack Integrity Checker"
HOMEPAGE="http://isic.sourceforge.net/"
SRC_URI="mirror://sourceforge/isic/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1"

src_compile() {
	econf --prefix="${D}/usr" --exec_prefix="${D}/usr" || die "configure died"
	emake || die "make failed"
}

src_install() {
	make install || die "make install failed"
	dodoc README
}
