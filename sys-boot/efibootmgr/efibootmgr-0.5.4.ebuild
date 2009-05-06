# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/efibootmgr/efibootmgr-0.5.4.ebuild,v 1.2 2009/05/06 18:34:52 maekke Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Interact with the EFI Boot Manager on IA-64 Systems"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="http://linux.dell.com/efibootmgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="sys-apps/pciutils"
DEPEND="${RDEPEND}"

pkg_config() {
	# should prob get moved into tc-funcs or something ...
	if [[ ${PKG_CONFIG+set} == "set" ]] ; then
		echo ${PKG_CONFIG}
	elif type -p ${CHOST}-pkg-config >/dev/null ; then
		echo ${CHOST}-pkg-config
	else
		echo pkg-config
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^LIBS/s:=.*:=$($(pkg_config) libpci --libs):" \
		src/efibootmgr/module.mk || die
}

src_compile() {
	strip-flags
	tc-export CC
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	# build system uses perl, so just do it ourselves
	dosbin src/efibootmgr/efibootmgr || die
	doman src/man/man8/efibootmgr.8
	dodoc AUTHORS README doc/ChangeLog doc/TODO
}
