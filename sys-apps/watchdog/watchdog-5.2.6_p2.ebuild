# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/watchdog-5.2.6_p2.ebuild,v 1.1 2006/07/13 17:16:49 phreak Exp $

inherit eutils

MY_P=${PN}_${PV/_p*/}
S="${WORKDIR}"/${P/_p*/}.orig
PATCH_LEVEL=${PV##*_p}

DESCRIPTION="A software watchdog"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="mirror://debian/pool/main/w/watchdog/${MY_P}.orig.tar.gz
		mirror://debian/pool/main/w/watchdog/${MY_P}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~sh ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-${PV/_p*/}-sundries.patch
	epatch "${FILESDIR}"/${PN}-${PV/_p*/}-uclibc.patch
	epatch "${WORKDIR}"/${MY_P}-${PATCH_LEVEL}.diff
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}

	dodoc AUTHORS README TODO
	docinto examples
	dodoc examples/*
}
