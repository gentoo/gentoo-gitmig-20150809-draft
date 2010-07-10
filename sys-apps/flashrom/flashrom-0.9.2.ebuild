# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/flashrom/flashrom-0.9.2.ebuild,v 1.4 2010/07/10 15:13:44 fauli Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Utility for reading, writing, erasing and verifying flash ROM chips"
HOMEPAGE="http://flashrom.org"
SRC_URI="http://qa.coreboot.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="buspiratespi drkaiser dummy ftdi +internal nic3com nvidia satasii serprog wiki"

COMMON_DEPEND="drkaiser? ( sys-apps/pciutils )
	internal? ( sys-apps/pciutils )
	nic3com? ( sys-apps/pciutils )
	nvidia? ( sys-apps/pciutils )
	satasii? ( sys-apps/pciutils )
	ftdi? ( dev-embedded/libftdi )"
RDEPEND="${COMMON_DEPEND}
	internal? ( sys-apps/dmidecode )"
DEPEND="${COMMON_DEPEND}
	sys-apps/diffutils"

_flashrom_enable() {
	local flag=${1}
	local macro=${2}

	if use $flag; then
		args="${args} ${macro}=yes"
	else
		args="${args} ${macro}=no"
	fi
}

src_compile() {
	local progs=0
	local args=""

	# Programmer
	_flashrom_enable buspiratespi CONFIG_BUSPIRATESPI
	_flashrom_enable drkaiser CONFIG_DRKAISER
	_flashrom_enable ftdi CONFIG_FT2232SPI
	_flashrom_enable nic3com CONFIG_NIC3COM
	_flashrom_enable nvidia CONFIG_GFXNVIDIA
	_flashrom_enable satasii CONFIG_SATASII
	_flashrom_enable serprog CONFIG_SERPROG

	_flashrom_enable internal CONFIG_INTERNAL
	_flashrom_enable dummy CONFIG_DUMMY
	_flashrom_enable wiki CONFIG_PRINT_WIKI

	# You have to specify at least one programmer, and if you specify more than
	# one programmer you have to include either dummy or internal in the list.
	for prog in buspiratespi drkaiser ftdi nic3com nvidia satasii serprog;
	do
		use $prog && progs=$((progs + 1))
	done
	if [ $progs -ne 1 ]; then
		if ! use internal && ! use dummy; then
			ewarn "You have to specify at least one programmer,"
			ewarn "and if you specify more than one programmer you have to enable"
			ewarn "either dummy or internal as well"
			ewarn "'internal' will be the default now"
			sleep 3
			args="${args} CONFIG_INTERNAL=yes"
		fi
	fi

	emake CC="$(tc-getCC)" ${args} || die
}

src_install() {
	dosbin flashrom || die
	doman flashrom.8
	dodoc ChangeLog README
}
