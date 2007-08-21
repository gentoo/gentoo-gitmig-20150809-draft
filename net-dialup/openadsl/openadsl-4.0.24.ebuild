# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/openadsl/openadsl-4.0.24.ebuild,v 1.1 2007/08/21 20:55:09 mrness Exp $

inherit linux-mod

MY_P="pulsar-${PV}"

DESCRIPTION="Driver for Pulsar PCI ADSL card"
HOMEPAGE="http://sf.net/projects/openadsl"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="ATM"
ATM_ERROR="${P} requires ATM support (CONFIG_ATM)."

MODULE_NAMES="pulsar_atm(net:)"
BUILD_TARGETS="default"
BUILD_PARAMS="KDIR=${KV_DIR}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-makefile.2.6.patch"

	if kernel_is lt 2 6 0 ; then
		mv "${S}"/makefile.2.4 "${S}"/Makefile || die "unable to copy Makefile"
	else
		mv "${S}"/makefile.2.6 "${S}"/Makefile || die "unable to copy Makefile"
	fi
}
