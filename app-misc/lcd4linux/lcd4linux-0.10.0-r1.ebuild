# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.10.0-r1.ebuild,v 1.3 2009/05/16 09:00:26 robbat2 Exp $

inherit eutils

DESCRIPTION="Shows system and ISDN information on an external display or in a X11 window"
HOMEPAGE="http://ssl.bulix.org/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="mysql"

# The following array holds the USE_EXPANDed keywords
IUSE_LCD_DEVICES=(beckmannegle bwct cfontz ncurses cwlinux
		hd44780 lcdlinux lcdterm m50530 mtxorb
		milfordbpk noritake null png ppm
		routerboard serdisplib simplelcd t6963 trefon
		usblcd X)

# Iterate through the array and add the lcd_devices_* that we support
NUM_DEVICES=${#IUSE_LCD_DEVICES[@]}
index=0
while [ "${index}" -lt "${NUM_DEVICES}" ] ; do
	IUSE="${IUSE} lcd_devices_${IUSE_LCD_DEVICES[$index]}"
	let "index = ${index} + 1"
done

DEPEND="
	mysql? ( virtual/mysql )

	lcd_devices_bwct?     ( =virtual/libusb-0* )
	lcd_devices_trefon?   ( =virtual/libusb-0* )
	lcd_devices_usblcd?   ( =virtual/libusb-0* )
	lcd_devices_ncurses?  ( sys-libs/ncurses )
	lcd_devices_noritake? ( media-libs/gd )
	lcd_devices_t6963?    ( media-libs/gd )
	lcd_devices_png?      ( media-libs/libpng media-libs/gd )
	lcd_devices_X?        ( x11-libs/libX11  media-libs/gd )
	lcd_devices_serdisplib? ( dev-libs/serdisplib  media-libs/gd )"
#	python support is b0rked, waiting for upstream release to fix
# 	python? ( dev-lang/python )

pkg_setup() {
	elog "If you wish to compile only specific plugins, please use"
	elog "the LCD4LINUX_PLUGINS environment variable. Plugins must be comma separated and can be either of:"
	elog "apm cpuinfo diskstats dvb exec i2c_sensors imon isdn loadavg meminfo netdev pop3 ppp proc_stat sample seti statfs uname uptime wireless"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-kernel2.6.19.patch"
	epatch "${FILESDIR}/${P}-gcc4-compat.patch"
	epatch "${FILESDIR}/${P}-null-driver.patch"
}

src_compile() {
	# This array contains the driver names required by configure --with-drivers=
	# The positions must be the same as the corresponding use_expand flags
	local DEVICE_DRIVERS=(BeckmannEgle BWCT CrystalFontz Curses Cwlinux
		HD44780 LCDLinux LCDTerm M50530 MatrixOrbital
		MilfordInstruments Noritake NULL PNG PPM
		RouterBoard serdisplib SimpleLCD T6963 Trefon
		USBLCD X11)

	local myconf myp

	# need to grab upstream's *.m4 and fix python building
	# they didn't have python properly set up originally.
	#myconf="${myconf} $(use_with python)"
	myconf="${myconf} --without-python"

	# plugins
	if [ -n "$LCD4LINUX_PLUGINS" ]; then
		myp="$LCD4LINUX_PLUGINS"
		use mysql || myp="${myp},!mysql"
		myp="${myp},!python"
		#use python || myp="${myp},!python"
		elog "Active plugins (overridden): ${myp}"
	else
		myp="all"
		use mysql || myp="${myp},!mysql"
		#use python || myp="${myp},!python"
		myp="${myp},!python"
		elog "Active plugins: ${myp}"
	fi

	# Generate comma separated list of drivers
	local COMMA_DRIVERS
	local FIRST_DRIVER
	local index=0
	local driver

	while [ "${index}" -lt "${NUM_DEVICES}" ] ; do
		if use "lcd_devices_${IUSE_LCD_DEVICES[$index]}" ; then
			driver=${DEVICE_DRIVERS[$index]}
			if [ -z ${COMMA_DRIVERS} ] ; then
				# First in the list
				COMMA_DRIVERS="${driver}"
				FIRST_DRIVER="${driver}"
			else
				# Second, third, ... include a comma at the front
				COMMA_DRIVERS="${COMMA_DRIVERS},${driver}"
			fi
		fi
		let "index = ${index} + 1"
	done

	# activate at least one driver
	if [ -z ${COMMA_DRIVERS} ] ; then
		COMMA_DRIVERS="NULL"
	fi

	# avoid package brokenness
	use lcd_devices_X && myconf="${myconf} --x-libraries=/usr/lib --x-include=/usr/include"
	use lcd_devices_X || myconf="${myconf} --without-x"

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="${COMMA_DRIVERS}" \
		--with-plugins="${myp}" \
		${myconf} \
		|| die "econf failed"

	sed -i.orig -e 's/-L -lX11/ -lX11 /g' Makefile || die "sed fixup failed"

	emake || die "make failed"
}

src_install() {
	# upstream's makefile acts weird, and tries to recompile stuff
	dobin lcd4linux

	dodoc README* NEWS TODO CREDITS FAQ AUTHORS ChangeLog

	newinitd "${FILESDIR}/${P}.initd" ${PN}

	insinto /etc
	insopts -o root -g root -m 0600
	newins lcd4linux.conf.sample lcd4linux.conf
}

pkg_postinst() {
	if use lcd_devices_lcdlinux; then
		ewarn "To actually use the lcd-linux devices, you will need to install the lcd-linux kernel module."
		ewarn "You can either do that yourself, see http://lcd-linux.sf.net or "
		ewarn "checkout http://overlays.gentoo.org/dev/jokey/browser/trunk and emerge app-misc/lcd-linux"
	fi
	ewarn "If you are upgrading, please note that the default config file was moved to /etc/lcd4linux.conf"
}
