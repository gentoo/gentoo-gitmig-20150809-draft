# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.10.1_rc2-r2.ebuild,v 1.9 2012/05/06 16:24:52 pacho Exp $

EAPI=4
PYTHON_DEPEND="python? 2"
WANT_AUTOMAKE="1.9"
inherit eutils multilib autotools python

MY_P=${P/_rc/-RC}

DESCRIPTION="Shows system and ISDN information on an external display or in a X11 window"
HOMEPAGE="http://ssl.bulix.org/projects/lcd4linux"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="mysql python iconv mpd"

# The following array holds the USE_EXPANDed keywords
IUSE_LCD_DEVICES=(beckmannegle bwct cfontz ncurses cwlinux
		ea232 g15 hd44780 hd44780i2c lcd2usb
		lcdlinux lcdterm ledmatrix lph7508 m50530
		mtxorb milfordbpk noritake null picolcd
		png ppm routerboard serdisplib simplelcd
		t6963 trefon usbhub usblcd wincor
		X luise)

# Iterate through the array and add the lcd_devices_* that we support
NUM_DEVICES=${#IUSE_LCD_DEVICES[@]}
index=0
while [ "${index}" -lt "${NUM_DEVICES}" ] ; do
	IUSE="${IUSE} lcd_devices_${IUSE_LCD_DEVICES[$index]}"
	let "index = ${index} + 1"
done

DEPEND="
	mysql?  ( virtual/mysql )
	iconv?  ( virtual/libiconv )
	mpd?    ( media-libs/libmpd )

	lcd_devices_bwct?     ( =virtual/libusb-0* )
	lcd_devices_g15?      ( =virtual/libusb-0* )
	lcd_devices_lcd2usb?  ( =virtual/libusb-0* )
	lcd_devices_picolcd?  ( =virtual/libusb-0* )
	lcd_devices_trefon?   ( =virtual/libusb-0* )
	lcd_devices_usbhub?   ( =virtual/libusb-0* )
	lcd_devices_usblcd?   ( =virtual/libusb-0* )
	lcd_devices_luise?    ( dev-libs/luise-bin )
	lcd_devices_ncurses?  ( sys-libs/ncurses )
	lcd_devices_noritake? ( media-libs/gd )
	lcd_devices_t6963?    ( media-libs/gd )
	lcd_devices_png?      ( media-libs/libpng media-libs/gd )
	lcd_devices_X?        ( x11-libs/libX11  media-libs/gd )
	lcd_devices_serdisplib? ( dev-libs/serdisplib  media-libs/gd )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	elog "If you wish to compile only specific plugins, please use"
	elog "the LCD4LINUX_PLUGINS environment variable. Plugins must be comma separated and can be either of:"
	elog "apm cpuinfo diskstats dvb exec file i2c_sensors imon isdn kvv loadavg meminfo netdev pop3 ppp proc_stat seti statfs uname uptime wireless"

	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-warnings.patch"
	epatch "${FILESDIR}/${P}-mpd.patch"
	epatch "${FILESDIR}/${P}-nordtsc.patch"
	epatch "${FILESDIR}/${P}-autoconf-2.65.patch"
	epatch "${FILESDIR}/${P}-missing-header.patch"
	eautoreconf
}

src_configure() {
	# This array contains the driver names required by configure --with-drivers=
	# The positions must be the same as the corresponding use_expand flags
	local DEVICE_DRIVERS=(BeckmannEgle BWCT CrystalFontz Curses Cwlinux
		EA232graphic G15 HD44780 HD44780-I2C LCD2USB
		LCDLinux LCDTerm LEDMatrix LPH7508 M50530
		MatrixOrbital MilfordInstruments Noritake NULL picoLCD
		PNG PPM RouterBoard serdisplib SimpleLCD
		T6963 Trefon USBHUB USBLCD WincorNixdorf
		X11 LUIse)

	local myconf myp

	# plugins
	if [ -n "$LCD4LINUX_PLUGINS" ]; then
		myp="$LCD4LINUX_PLUGINS"
	else
		myp="all,!xmms"
	fi
	use iconv || myp="${myp},!iconv"
	use mpd || myp="${myp},!mpd"
	use mysql || myp="${myp},!mysql"
	use python || myp="${myp},!python"
	elog "Active plugins: ${myp}"

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

	# workaround the build failing because of b0rked settings
	if use lcd_devices_hd44780 && use lcd_devices_hd44780i2c ; then
		echo
		ewarn "Disabling hd44780 LCD_DEVICE as hd44780i2c is set!"
		echo
		COMMA_DRIVERS="${COMMA_DRIVERS},!HD44780"
	fi

	# avoid package brokenness
	if use lcd_devices_X ; then
		myconf="--x-libraries=/usr/$(get_libdir) --x-include=/usr/include"
	else
		myconf="--without-x"
	fi

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="${COMMA_DRIVERS}" \
		--with-plugins="${myp}" \
		$(use_with python) \
		${myconf} \
		|| die "econf failed"

	sed -i.orig -e 's/-L -lX11/ -lX11 /g' Makefile || die "sed fixup failed"
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README ChangeLog

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
