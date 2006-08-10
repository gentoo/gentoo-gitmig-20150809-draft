# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nzbget/nzbget-0.2.3.ebuild,v 1.3 2006/08/10 20:14:07 swegener Exp $

inherit eutils

DESCRIPTION="A command-line based binary newsgrabber supporting .nzb files"
HOMEPAGE="http://sourceforge.net/projects/nzbget/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"

DEPEND="dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.2.3-include-order.patch
	epatch "${FILESDIR}"/0.2.3-gcc41.patch
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake CFLAGS="-I. -DHAVE_CONFIG_H -D_GNU_SOURCE ${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin nzbget || die "dobin failed"
	dodoc CHANGELOG README TODO nzbget.cfg.example || die "dodoc failed"
}
