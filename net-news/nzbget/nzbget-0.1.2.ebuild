# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/nzbget/nzbget-0.1.2.ebuild,v 1.2 2004/09/02 23:23:36 kugelfang Exp $

DESCRIPTION="A command-line based binary newsgrabber supporting .nzb files"
HOMEPAGE="http://nzbget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"

DEPEND="dev-libs/libxml2"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	# Bad configure script is forcing CFLAGS, so we pass our own
	emake CFLAGS="-I. -DHAVE_CONFIG_H -D_GNU_SOURCE ${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin nzbget || die "dobin failed"
	dodoc CHANGELOG README TODO nzbget.cfg.example || die "dodoc failed"
}
