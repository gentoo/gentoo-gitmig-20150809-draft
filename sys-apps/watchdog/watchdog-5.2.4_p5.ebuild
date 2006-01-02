# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/watchdog-5.2.4_p5.ebuild,v 1.4 2006/01/02 17:37:58 hansmi Exp $

inherit eutils

MY_P=${PN}_${PV/_p*/}
S=${WORKDIR}/${P/_p*/}.orig

DESCRIPTION="A software watchdog"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="mirror://debian/pool/main/w/watchdog/${MY_P}.orig.tar.gz
		mirror://debian/pool/main/w/watchdog/${MY_P}-5.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~mips ppc sh x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-sundries.patch
	epatch "${FILESDIR}"/${P}-uclibc.patch
	epatch "${WORKDIR}"/${MY_P}-5.diff
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newconfd ${FILESDIR}/${P}-conf.d ${PN}
	newinitd ${FILESDIR}/${P}-init.d ${PN}

	dodoc AUTHORS README TODO
	docinto examples
	dodoc examples/*
}

pkg_postinst() {
	einfo
	einfo "To enable the start-up script run:"
	einfo "  # rc-update add watchdog boot"
	einfo

	if [[ -f ${ROOT}/etc/watchdog/watchdog.conf ]]; then
		ewarn
		ewarn "Please notice that this release changes the configuration file"
		ewarn "location to the standard /etc/watchdog.conf location. Make sure"
		ewarn "you move the old /etc/watchdog/watchdog.conf file there."
		ewarn
	fi
}
