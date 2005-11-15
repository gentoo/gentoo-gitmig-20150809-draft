# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shapecfg/shapecfg-36.ebuild,v 1.1 2005/11/15 00:48:55 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="configuration tool for setting traffic bandwidth parameters"
HOMEPAGE=""
SRC_URI="mirror://gentoo/shaper.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/shaper

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/shapercfg-2.0.36-glibc.patch
	rm -f Makefile
}

src_compile() {
	append-flags -Wall
	emake shapecfg || die
}

src_install() {
	dobin shapecfg || die
	dodoc "${FILESDIR}"/README.shaper
}
