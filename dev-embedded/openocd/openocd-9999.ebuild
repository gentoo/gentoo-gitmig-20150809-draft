# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/openocd/openocd-9999.ebuild,v 1.2 2008/06/04 17:03:03 flameeyes Exp $

ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/openocd/trunk"
inherit eutils subversion autotools

DESCRIPTION="OpenOCD - Open On-Chip Debugger"
HOMEPAGE="http://openocd.berlios.de/web/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ft2232 ftdi parport presto"
RESTRICT="strip" # includes non-native binaries

# libftd2xx is the default because it is reported to work better.
DEPEND="presto? ( dev-embedded/libftd2xx )
	ft2232? ( || ( ftdi? ( dev-embedded/libftdi ) dev-embedded/libftd2xx ) )"

pkg_setup() {
	if use ftdi && ! use ft2232 ; then
		ewarn "You enabled libftdi but not ft2232!"
		ewarn "libftdi is only used for ft2232, so this is meaningless!"
	fi
}

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf \
		--enable-parport \
		--enable-parport_ppdev \
		--enable-amtjtagaccel \
		--enable-ep93xx \
		--enable-at91rm9200 \
		--enable-gw16012 \
		--enable-usbprog \
		--enable-oocd_trace \
		$(use_enable parport parport_giveio) \
		$(use_enable presto presto_ftd2xx) \
		$(use ft2232 && use_enable ftdi ft2232_libftdi) \
		$(use ft2232 && use_enable !ftdi ft2232_ftd2xx) \
		|| die "Error in econf!"
	emake || die "Error in emake!"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepstrip "${D}"/usr/bin
}
