# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-module/tpm-module-2.0.ebuild,v 1.1 2005/02/03 11:16:08 dragonheart Exp $

inherit linux-mod

MY_P=tpm-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Driver for TPM chips"

HOMEPAGE="http://www.research.ibm.com/gsal/tcpa/"
SRC_URI="http://www.research.ibm.com/gsal/tcpa/TPM-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""

BUILD_PARAMS="KDIR=${KV_DIR}"
BUILD_TARGETS="default"
MODULE_NAMES="tpm(crypto:)"

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}
