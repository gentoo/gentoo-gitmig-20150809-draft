# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c-tools/i2c-tools-3.0.2.ebuild,v 1.1 2009/01/14 16:19:33 vapier Exp $

inherit flag-o-matic toolchain-funcs distutils

DESCRIPTION="I2C tools for bus probing, chip dumping, register-level access helpers, EEPROM decoding scripts, and more"
HOMEPAGE="http://www.lm-sensors.org/wiki/I2CTools"
SRC_URI="http://dl.lm-sensors.org/i2c-tools/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="python"

DEPEND="!<sys-apps/lm_sensors-3"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die
	if use python ; then
		cd py-smbus
		append-cppflags -I../include
		distutils_src_compile
	fi
}

src_install() {
	emake install prefix="${D}"/usr || die
	rm -rf "${D}"/usr/include # part of linux-headers
	dodoc CHANGES README
	local d
	for d in eeprom eepromer ; do
		docinto ${d}
		dodoc ${d}/README*
	done

	if use python ; then
		cd py-smbus
		docinto py-smbus
		dodoc README*
		distutils_src_install
	fi
}
