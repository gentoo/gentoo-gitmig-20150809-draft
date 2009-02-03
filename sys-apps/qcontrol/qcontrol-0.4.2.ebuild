# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qcontrol/qcontrol-0.4.2.ebuild,v 1.2 2009/02/03 11:24:36 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Allows to send commands to some microcontrollers, for example to change leds or sound a buzzer"
HOMEPAGE="http://qnap.nas-central.org/index.php/PIC_Control_Software"
SRC_URI="http://byronbradley.co.uk/piccontrol/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=">=dev-lang/lua-5.1"
RDEPEND="${DEPEND}"

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin qcontrol
	doman "${FILESDIR}"/qcontrol.1

	insinto /etc/qcontrol
	doins "${FILESDIR}"/*.lua

	device=$(grep "Hardware[[:space:]]*:" /proc/cpuinfo 2>/dev/null | \
		head -n1 | sed "s/^[^:]*: //")
	case $device in
		"QNAP TS-109/TS-209")
		dosym /etc/qcontrol/ts209.lua /etc/qcontrol.conf ;;
		"QNAP TS-409")
		dosym /etc/qcontrol/ts409.lua /etc/qcontrol.conf ;;
		*)
		die "Your device is unsupported" ;;
	esac

	newconfd "${FILESDIR}"/conf.d qcontrol
	newinitd "${FILESDIR}"/init.d qcontrol
}
