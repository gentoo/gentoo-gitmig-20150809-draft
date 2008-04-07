# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c-tools/i2c-tools-3.0.0.ebuild,v 1.4 2008/04/07 21:32:17 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="I2C tools for bus probing, chip dumping, register-level access helpers, EEPROM decoding scripts, and more"
HOMEPAGE="http://www.lm-sensors.org/wiki/I2CTools"
SRC_URI="http://dl.lm-sensors.org/i2c-tools/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!<sys-apps/lm_sensors-3"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake install prefix="${D}"/usr || die
	dodoc CHANGES README
	local d
	for d in eeprom eepromer py-smbus ; do
		docinto ${d}
		dodoc ${d}/README*
	done
}
