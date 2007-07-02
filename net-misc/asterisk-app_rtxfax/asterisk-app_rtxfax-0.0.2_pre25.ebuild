# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_rtxfax/asterisk-app_rtxfax-0.0.2_pre25.ebuild,v 1.2 2007/07/02 14:57:52 peper Exp $

IUSE=""

inherit eutils

MY_PN="app_rtxfax"

DESCRIPTION="Asterisk applications for sending and receiving faxes"
HOMEPAGE="http://www.soft-switch.org/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://www.netdomination.org/pub/asterisk/${P}.tar.bz2"

RESTRICT="mirror"

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
	epatch ${FILESDIR}/${MY_PN}-0.0.2_pre25-gentoo.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README
}
