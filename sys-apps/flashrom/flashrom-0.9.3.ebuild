# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/flashrom/flashrom-0.9.3.ebuild,v 1.1 2010/12/03 17:25:28 idl0r Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="Utility for reading, writing, erasing and verifying flash ROM chips"
HOMEPAGE="http://flashrom.org"
SRC_URI="http://qa.coreboot.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="atahpt bitbang_spi buspirate_spi dediprog drkaiser
dummy ft2232_spi gfxnvidia +internal nic3com nicintel_spi nicnatsemi nicrealtek rayer_spi
satasii serprog +wiki"

COMMON_DEPEND="atahpt? ( sys-apps/pciutils )
	dediprog? ( virtual/libusb:0 )
	drkaiser? ( sys-apps/pciutils )
	ft2232_spi? ( dev-embedded/libftdi )
	gfxnvidia? ( sys-apps/pciutils )
	internal? ( sys-apps/pciutils )
	nic3com? ( sys-apps/pciutils )
	nicintel_spi? ( sys-apps/pciutils )
	nicnatsemi? ( sys-apps/pciutils )
	nicrealtek? ( sys-apps/pciutils )
	rayer_spi? ( sys-apps/pciutils )
	satasii? ( sys-apps/pciutils )"
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
	_flashrom_enable atahpt CONFIG_ATAHPT
	_flashrom_enable bitbang_spi CONFIG_BITBANG_SPI
	_flashrom_enable buspirate_spi CONFIG_BUSPIRATE_SPI
	_flashrom_enable dediprog CONFIG_DEDIPROG
	_flashrom_enable drkaiser CONFIG_DRKAISER
	_flashrom_enable ft2232_spi CONFIG_FT2232_SPI
	_flashrom_enable gfxnvidia CONFIG_GFXNVIDIA
	_flashrom_enable nic3com CONFIG_NIC3COM
	_flashrom_enable nicintel_spi CONFIG_NICINTEL_SPI
	_flashrom_enable nicnatsemi CONFIG_NICNATSEMI
	_flashrom_enable nicrealtek CONFIG_NICREALTEK
	_flashrom_enable rayer_spi CONFIG_RAYER_SPI
	_flashrom_enable satasii CONFIG_SATASII
	_flashrom_enable serprog CONFIG_SERPROG

	_flashrom_enable internal CONFIG_INTERNAL
	_flashrom_enable dummy CONFIG_DUMMY
	_flashrom_enable wiki CONFIG_PRINT_WIKI

	# You have to specify at least one programmer, and if you specify more than
	# one programmer you have to include either dummy or internal in the list.
	for prog in $IUSE; do
		prog=$(echo $prog | sed 's:^[+-]::')

		[ "${prog}" = "internal" ] || [ "${prog}" = "dummy" ] || [ "${prog}" = "wiki" ] && continue

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
