# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcdproc/lcdproc-0.5.1.ebuild,v 1.2 2006/10/18 23:36:16 jokey Exp $

inherit eutils flag-o-matic

DESCRIPTION="Client/Server suite to drive all kinds of LCD (-like) devices"
HOMEPAGE="http://lcdproc.org/"
SRC_URI="mirror://sourceforge/lcdproc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# general use keywords in first line, drivers in line 2
IUSE="doc debug ldap nfs samba seamless-hbars usb
	g15 graphlcd irman lirc ncurses svga ula200 xosd"

DEPEND="
	doc?      ( app-text/xmlto )
	ldap?     ( net-nds/openldap )
	usb?      ( dev-libs/libusb )

	graphlcd? ( app-misc/graphlcd-base  app-misc/glcdprocdriver )
	g15?      ( app-misc/g15daemon  dev-libs/libg15  >=dev-libs/libg15render-1.1.1 )
	irman?    ( media-libs/libirman )
	lirc?     ( app-misc/lirc )
	ncurses?  ( sys-libs/ncurses )
	svga?     ( media-libs/svgalib )
	ula200?   ( dev-embedded/libftdi  dev-libs/libusb )
	xosd?     ( x11-libs/xosd  x11-libs/libX11  x11-libs/libXext ) "
RDEPEND=${DEPEND}

USE_DRIVERS="curses g15 glcdlib irman lirc svga ula200 xosd"
EXTRA_DRIVERS="bayrad CFontz CFontz633 CFontzPacket CwLnx EyeboxOne \
	glk hd44780 icp_a106 imon IOWarrior joy lb216 lcdm001 \
	lcterm MD8800 ms6931 mtc_s16209x MtxOrb NoritakeVFD pyramid sed1330 \
	sed1520 serialVFD sli stv5730 t6963 text tyan "
ALL_DRIVERS="${USE_DRIVERS} ${EXTRA_DRIVERS}"


# compatibility with 1.4-ebuild format
LCDPROC_DRIVERS=${LCDPROC_DRIVERS//,/ }

# if no drivers or all are set, select the defaults
has all ${LCDPROC_DRIVERS} \
	&& LCDPROC_DRIVERS="${EXTRA_DRIVERS}"
[ -z "${LCDPROC_DRIVERS}" ] \
	&& LCDPROC_DRIVERS="${EXTRA_DRIVERS}"
has none ${LCDPROC_DRIVERS} \
	&& LCDPROC_DRIVERS=""


pkg_setup() {
	echo
	einfo "If you are updating from lcdproc-0.4, note that the setup of drivers has changed:"
	einfo "The drivers ${USE_DRIVERS// /, } are controlled by use flags."
	einfo "All other drivers are built by default, or in respect to the env variable"
	einfo "LCDPROC_DRIVERS which can be a space separated list. Example:"
	einfo "     LCDPROC_DRIVERS=\"text CFontz\" emerge lcdproc"
	einfo "You can also set this variable in your make.conf."
	echo
	einfo "Possible choices for LCDPROC_DRIVERS are:"

	# Nice Output of EXTRA_DRIVERS
	local LINE="   "
	local ELEM=0
	for driver in ${EXTRA_DRIVERS}; do
		ELEM=$((${ELEM}+1))
		LINE="${LINE} ${driver}"
		if [ "${ELEM}" = 8 ]; then
			einfo "${LINE}"
			ELEM=0
			LINE="   "
		fi
	done
	if [ ! "${ELEM}" = 0 ]; then
		einfo "${LINE}"
	fi

	einfo "   'all' if you want to include all drivers (default)."
	einfo "   'none' will not include any extra drivers."
	echo

	local FILTERED_DRIVERS
	for driver in ${LCDPROC_DRIVERS}; do
		if has ${driver} ${EXTRA_DRIVERS} ; then
				FILTERED_DRIVERS="${FILTERED_DRIVERS} ${driver}"
			else
				eerror "The extra driver '${driver}' is not available or has to be enabled by a USE flag."
				eerror "Please check your LCDPROC_DRIVERS variable!"
				echo
		fi
	done
	LCDPROC_DRIVERS="${FILTERED_DRIVERS}"

	# add use-flag specific drivers to LCDPROC_DRIVERS
	use graphlcd && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} glcdlib"
	use g15      && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} g15"
	use irman    && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} irman"
	use lirc     && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} lirc"
	use ncurses  && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} curses"
	use svga     && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} svga"
	use ula200   && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} ula200"
	use xosd     && LCDPROC_DRIVERS="${LCDPROC_DRIVERS} xosd"

	einfo "The following drivers will be built: "
	echo

	for driver in ${ALL_DRIVERS}; do
		has ${driver} ${LCDPROC_DRIVERS} && einfo $driver
		if (! use usb) && (has ${driver} "CFontzPacket CwLnx pyramid"); then
			ewarn "${driver} might not compile if you do not enable USE=\"usb\""
		fi
	done
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-LCDd-conf-driver-path.patch"
}

src_compile() {
	# avoid executable stack as mentioned
	# in http://www.gentoo.org/proj/en/hardened/gnu-stack.xml
	append-ldflags -Wl,-z,noexecstack

	# convert space separated LCDPROC_DRIVERS to comma separated COMMA_DRIVERS
	local COMMA_DRIVERS
	for driver in ${LCDPROC_DRIVERS}; do
	    if [ -z "${COMMA_DRIVERS}" ] ; then
			COMMA_DRIVERS="${driver}"
		else
			COMMA_DRIVERS="${COMMA_DRIVERS},${driver}"
		fi
	done

	econf \
		$(use_enable debug) \
		$(use_enable ldap) \
		$(use_enable nfs stat-nfs) \
		$(use_enable samba stat-smbfs ) \
		$(use_enable seamless-hbars) \
		$(use_enable usb libusb) \
		"--enable-drivers=${COMMA_DRIVERS}"  \
		|| die "configure failed"

	emake || die "make failed"

	if use doc; then
		ebegin "Creating user documentation"
		cd ${S}/docs/lcdproc-user
		xmlto html lcdproc-user.docbook
		eend 0
		ebegin "Creating dev documentation"
		cd ${S}/docs/lcdproc-dev
		xmlto html lcdproc-dev.docbook
		eend 0
	fi
}

src_install() {
	dosbin server/LCDd
	dobin clients/lcdexec/lcdexec
	dobin clients/lcdproc/lcdproc
	dobin clients/lcdvc/lcdvc

	insinto /usr/share/lcdproc/drivers
	doins server/drivers/*.so

	insinto /usr/share/lcdproc/clients
	doins clients/examples/*.pl
	doins clients/metar/lcdmetar.pl

	insinto /etc
	doins LCDd.conf
	doins clients/lcdexec/lcdexec.conf
	doins clients/lcdproc/lcdproc.conf
	doins clients/lcdvc/lcdvc.conf

	newinitd "${FILESDIR}/${PV}-LCDd.rc" LCDd
	newinitd "${FILESDIR}/${PV}-lcdproc.rc" lcdproc

	doman docs/*.1 docs/*.5 docs/*.8
	dodoc README CREDITS ChangeLog INSTALL TODO
	dodoc docs/README.* docs/*.txt

	if use doc; then
		insinto /usr/share/doc/${PF}/lcdproc-user
		doins docs/lcdproc-user/*.html
		insinto /usr/share/doc/${PF}/lcdproc-dev
		doins docs/lcdproc-dev/*.html
	fi
}
