# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_rtxfax/asterisk-app_rtxfax-0.0.2_pre18.ebuild,v 1.2 2005/07/08 20:53:05 dholm Exp $

IUSE=""

inherit eutils

MY_PN="app_rtxfax"

DESCRIPTION="Asterisk applications for sending and receiving faxes"
HOMEPAGE="http://www.opencall.org/"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=media-libs/spandsp-0.0.2_pre18
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-0.0.2_pre10-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README
}
