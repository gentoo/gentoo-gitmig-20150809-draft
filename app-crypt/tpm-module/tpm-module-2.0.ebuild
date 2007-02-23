# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-module/tpm-module-2.0.ebuild,v 1.2 2007/02/23 15:30:10 alonbl Exp $

inherit linux-mod

MY_P=tpm-${PV}

DESCRIPTION="Driver for TPM chips"
HOMEPAGE="http://www.research.ibm.com/gsal/tcpa/"
SRC_URI="http://www.research.ibm.com/gsal/tcpa/TPM-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
	BUILD_TARGETS="default"
	MODULE_NAMES="tpm(crypto:)"
}

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}
