# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaimosd/gaimosd-1.0.0.ebuild,v 1.5 2005/02/18 18:30:21 rizzo Exp $

inherit eutils

DESCRIPTION="Gaim OSD is an implementation of the XOSD library, allowing Gaim to display several notification messages."
HOMEPAGE="http://gaimosd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND=">=net-im/gaim-1.0.0
	x11-libs/xosd"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gaimosd-quiet.diff
}

src_compile() {
	econf --enable-customized-buddies --enable-customized-conversations || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO
}
