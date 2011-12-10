# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430-binutils/msp430-binutils-2.21.1_p20111205.ebuild,v 1.2 2011/12/10 22:50:54 radhermit Exp $

EAPI="4"

inherit toolchain-binutils

MY_PV="${PV%_p*}"
DESCRIPTION="Tools necessary to build programs for MSP430 microcontrollers"
SRC_URI="mirror://gnu/binutils/binutils-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~radhermit/distfiles/${P}.patch.bz2"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/binutils-${MY_PV}"

pkg_pretend() {
	is_cross || die "Only cross-compile builds are supported"
}

src_prepare() {
	epatch "${WORKDIR}"/${P}.patch
}
