# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/openocd/openocd-9999.ebuild,v 1.6 2009/06/17 10:04:16 vapier Exp $

ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/openocd/trunk"
inherit eutils
if [[ ${PV} == "9999" ]] ; then
	inherit subversion autotools
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~x86"
	SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
fi

DESCRIPTION="OpenOCD - Open On-Chip Debugger"
HOMEPAGE="http://openocd.berlios.de/web/"

LICENSE="GPL-2"
SLOT="0"
IUSE="ftd2xx ftdi parport presto usb"
RESTRICT="strip" # includes non-native binaries

# libftd2xx is the default because it is reported to work better.
DEPEND="usb? ( dev-libs/libusb )
	presto? ( dev-embedded/libftd2xx )
	ftd2xx? ( dev-embedded/libftd2xx )
	ftdi? ( dev-embedded/libftdi )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use ftdi && use ftd2xx ; then
		ewarn "You can only use one FTDI library at a time, so picking"
		ewarn "USE=ftdi (open source) over USE=ftd2xx (closed source)"
	fi
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
		cd "${S}"
		eautoreconf
	else
		unpack ${A}
	fi
}

src_compile() {
	econf \
		--enable-parport \
		--enable-parport_ppdev \
		--enable-amtjtagaccel \
		--enable-ep93xx \
		--enable-at91rm9200 \
		--enable-gw16012 \
		--enable-oocd_trace \
		$(use_enable usb usbprog) \
		$(use_enable parport parport_giveio) \
		$(use_enable presto presto_ftd2xx) \
		$(use_enable ftdi ft2232_libftdi) \
		$(use ftdi || use_enable ftd2xx ft2232_ftd2xx)
	emake || die "Error in emake!"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepstrip "${D}"/usr/bin
}
