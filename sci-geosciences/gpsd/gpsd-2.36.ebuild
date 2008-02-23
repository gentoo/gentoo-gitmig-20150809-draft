# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsd/gpsd-2.36.ebuild,v 1.1 2008/02/23 20:03:58 nerdboy Exp $

inherit eutils autotools distutils

DESCRIPTION="GPS daemon and library to support USB/serial GPS devices and various GPS/mapping clients."
HOMEPAGE="http://gpsd.berlios.de/"
SRC_URI="http://download.berlios.de/gpsd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus italk itrax minimal ntp python usb X"
# tnt support is broken in this version - add tntc back when fixed

RDEPEND="X? (
		x11-libs/libXmu
		x11-libs/libXext
		x11-libs/libXp
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXpm
		x11-libs/libXaw
		virtual/motif
	)
	python? ( dev-lang/python )
	app-text/xmlto
	dev-libs/libxslt
	sys-libs/ncurses
	dbus? ( >=sys-apps/dbus-0.94
		>=dev-libs/glib-2.6
		dev-libs/dbus-glib )
	ntp? ( net-misc/ntp )
	usb? ( virtual/dev-manager )"

DEPEND="${RDEPEND}
	X? (
		x11-proto/xproto
		x11-proto/xextproto
	)"

RESTRICT="test"

WANT_AUTOMAKE="latest"
WANT_AUTOCONF=2.5

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {

	local my_conf="--enable-shared --with-pic --enable-static \
	    --disable-garmin --disable-garmintxt"
	# Garmin support is broken in this version

	use python && distutils_python_version

	if use ntp; then
	    my_conf="${my_conf} --enable-ntpshm --enable-pps"
	else
	    my_conf="${my_conf} --disable-ntpshm --disable-pps"
	fi

	if use minimal; then
	    local max_clients="5"
	    local max_devices="1"
	    my_conf="${my_conf} --enable-squelch --disable-pps"
	    my_conf="${my_conf} --enable-max-clients=${max_clients} \
		--enable-max-devices=${max_devices} \
		--without-x"
	else
	    my_conf="${my_conf} $(use_with X x)"
	fi

	econf ${my_conf} $(use_enable dbus) $(use_enable python) \
	    $(use_enable italk) $(use_enable itrax) \
	    || die "econf failed"
	    # Support for the TNT digital compass is currently broken
	    # $(use_enable tntc tnt)

	emake || die "emake failed"
}

src_install() {

	make DESTDIR="${D}" install

	if use usb ; then
	    insinto /etc/hotplug/usb
	    doins gpsd.usermap
	    exeinto /etc/hotplug/usb
	    doexe gpsd.hotplug
	    insinto /etc/udev/rules.d
	    doins "${FILESDIR}"/99-gpsd-usb.rules
	    keepdir /var/run/usb # needed for REMOVER
	else
	    newconfd "${FILESDIR}"/gpsd.conf gpsd
	    newinitd "${FILESDIR}"/gpsd.init gpsd
	fi

	if use X && ! use minimal ; then
	    insinto /etc/X11/app-defaults
	    newins xgps.ad Xgps
	    newins xgpsspeed.ad Xgpsspeed
	fi

	diropts "-m0644"
	dobin logextract

	if use python ; then
	    exeinto /usr/$(get_libdir)/python${PYVER}/site-packages
	    doexe gps.py gpsfake.py gpspacket.so
	fi

	dodoc AUTHORS INSTALL README TODO

	# add missing include file (see bug #162361)
	insinto /usr/include
	doins gpsd_config.h
}

pkg_postinst() {
	einfo ""
	einfo "This version of gpsd has broken the support for the TNT compass"
	einfo "so it is temporarily disabled.  If you need it, stay with the"
	einfo "previous version for now.  The minimal flag now removes X and"
	einfo "enables the embedded device (ie, small footprint) support, but"
	einfo "you'll need to modify the ebuild if you need to change either"
	einfo "the number of clients or the number of devices.  Although pps"
	einfo "is enabled, it still needs the correct kernel patches.  All"
	einfo "recent versions of udev (>=udev-115 or so) should have correct"
	einfo "usb device detection and startup of gpsd (ie, without hotplug)."
	einfo ""
	einfo "Most GPS devices will require the corresponding kernel options"
	einfo "to be enabled, such as USB_SERIAL_GARMIN, or a USB serial driver"
	einfo "for an adapter such as those that come with Deluo GPS units (eg,"
	einfo "USB_SERIAL_PL2303).  Straight serial devices should always work,"
	einfo "even without udev/hotplug support (assuming you have the serial"
	einfo "drivers enabled for your hardware)."
	einfo ""
	einfo "Read the INSTALL doc for more information on supported hardware,"
	einfo "and make sure udev has the right group permissions set on the"
	einfo "tty devices if using USB (it should Do The Right Thing (TM))..."
	einfo ""
}
