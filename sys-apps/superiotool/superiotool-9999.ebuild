# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/superiotool/superiotool-9999.ebuild,v 1.2 2011/01/09 17:36:19 idl0r Exp $

EAPI=3

inherit toolchain-funcs subversion

DESCRIPTION="user-space utility to detect Super I/O chips and functionality to
get more information about it"
HOMEPAGE="http://coreboot.org"
SRC_URI=""
ESVN_REPO_URI="svn://coreboot.org/coreboot/trunk/util/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="pci"

DEPEND="pci? ( sys-apps/pciutils )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:-Werror ::' \
		-e 's:-O2 ::' \
		-e 's:\s\+\?-lz\s\+\?::' \
		Makefile || die
}

src_compile() {
	local config_pci

	if use pci; then
		config_pci="yes"
	else
		config_pci="no"
	fi

	emake CC=$(tc-getCC) CONFIG_PCI=${config_pci} || die
}

src_install() {
	dosbin superiotool || die
	doman superiotool.8
	dodoc README
}
