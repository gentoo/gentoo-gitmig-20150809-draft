# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_rtxfax/asterisk-app_rtxfax-0.0.2_pre20.ebuild,v 1.1 2005/09/08 00:41:30 stkn Exp $

IUSE=""

inherit eutils

MY_PN="app_rtxfax"

DESCRIPTION="Asterisk applications for sending and receiving faxes"
HOMEPAGE="http://www.soft-switch.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=media-libs/spandsp-0.0.2_pre20
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-0.0.2_pre20-gentoo.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README
}
