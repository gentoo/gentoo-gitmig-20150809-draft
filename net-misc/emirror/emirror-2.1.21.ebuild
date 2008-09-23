# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/emirror/emirror-2.1.21.ebuild,v 1.7 2008/09/23 02:08:18 cla Exp $

DESCRIPTION="ECLiPt FTP mirroring tool"
HOMEPAGE="http://sourceforge.net/projects/emirror/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man/man1 \
		sysconfdir="${D}"/etc \
	install || die "emake install failed"
	dodoc doc/*
}
