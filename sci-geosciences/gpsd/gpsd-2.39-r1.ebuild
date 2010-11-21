# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsd/gpsd-2.39-r1.ebuild,v 1.7 2010/11/21 12:42:45 armin76 Exp $

EAPI="2"

inherit autotools eutils flag-o-matic python

DESCRIPTION="GPS daemon and library to support USB/serial GPS devices and various GPS/mapping clients."
HOMEPAGE="http://gpsd.berlios.de/"
SRC_URI="mirror://berlios/gpsd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"

IUSE="dbus garmin +gpsd_user -minimal ntp ocean pl2303 tntc usb X"

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
	)
	dbus? ( >=sys-apps/dbus-0.94
		>=dev-libs/glib-2.6
		dev-libs/dbus-glib )
	ntp? ( net-misc/ntp )
	usb? ( virtual/dev-manager )
	sys-libs/ncurses
	dev-lang/python"

DEPEND="${RDEPEND}
	X? (
		x11-proto/xproto
		x11-proto/xextproto
	)
	!minimal? (
		dev-libs/libxslt
	)"

pkg_setup() {
	# Run the gpsd daemon as user gpsd and group uucp, see bug #282130
	if use gpsd_user; then
		enewuser gpsd -1 -1 -1 "uucp"
	else
		einfo "USE=gpsd_user is disabled; no gpsd user added."
	fi
}

src_prepare() {
	# add -lm to setup.py again (see bug #250757)
	sed -i \
	    -e "s:, gpspacket_sources:, gpspacket_sources, libraries=['m']:g" \
	    -e "s:geoid.c\"]:geoid.c\"], libraries=['m']:g" \
	    setup.py || die "sed 1 failed"

	# fix Garmin text struct
	sed -i -e "s:RTCM2_PACKET;:RTCM2_PACKET,:g" \
	    drivers.c || die "sed 2 failed"

	# add missing include file (see bug #162361)
	sed -i -e "s:gps.h libgpsmm.h:gps.h libgpsmm.h gpsd_config.h:g" \
	    Makefile.am || die "sed 3 failed"

	eautoreconf
}

src_configure() {

	local my_conf="--enable-shared --with-pic --enable-static"
		# --enable-superstar2 is missing a header file

	# Drop privs to user gpsd, see bug #282130
	use gpsd_user && my_conf="${my_conf} --enable-gpsd-user=gpsd"

	if ! use ntp; then
		my_conf="${my_conf} --disable-pps --disable-ntpshm"
	fi

	if use minimal; then
		local max_clients="5"
		local max_devices="2"
		my_conf="${my_conf} --enable-squelch --without-x \
		--enable-max-devices=${max_devices} \
		--enable-max-clients=${max_clients}"

		WITH_XSLTPROC=no WITH_XMLTO=no econf ${my_conf} \
		$(use_enable dbus) $(use_enable ocean oceanserver) \
		$(use_enable tntc tnt) $(use_enable garmin garmintxt) \
		|| die "econf failed"
	else
		econf ${my_conf} $(use_enable dbus) $(use_enable tntc tnt) \
		$(use_enable ocean oceanserver) $(use_with X x) \
		$(use_enable garmin garmintxt) \
		|| die "econf failed"
	fi
}

src_compile() {
	# still needs an explicit link flag (bug #250757)
	append-ldflags -Wl,-z,-defs -Wl,--no-undefined

	emake -j1 || die "emake failed"
}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	if ! test -x "${D}"usr/sbin/gpsd; then
	    ewarn "gpsd link error detected; please re-emerge gpsd."
	fi

	if use usb ; then
		insinto /etc/hotplug/usb
		doins gpsd.usermap
		exeinto /etc/hotplug/usb
		doexe gpsd.hotplug
		insinto /etc/udev/rules.d
		doins "${FILESDIR}"/99-gpsd-usb.rules
		if use pl2303; then
			sed -i -e "1,7s:#ATTRS:ATTRS:" \
				-e "1,7s:#ENV:ENV:" \
				"${D}"/etc/udev/rules.d/99-gpsd-usb.rules
		fi
		keepdir /var/run/usb # needed for REMOVER
	else
		newconfd "${FILESDIR}"/gpsd.conf gpsd
		newinitd "${FILESDIR}"/gpsd.init gpsd
	fi

	if use X && ! use minimal ; then
		insinto /etc/X11/app-defaults
		newins xgps.ad Xgps
		newins xgpsspeed.ad Xgpsspeed
	else
		rm "${D}usr/share/man/man1/xgpsspeed.1.bz2" \
		"${D}usr/share/man/man1/xgps.1.bz2"
	fi

	python_src_install

	dodoc INSTALL README TODO

	# add missing dgpsip-servers and capabilities files
	insinto /usr/share/${PN}
	doins dgpsip-servers gpscap.ini

	if use minimal; then
		doman gpsctl.1 gpsd.8 gps.1 cgps.1 gpxlogger.1 gpspipe.1 gpsprof.1
	else
		diropts "-m0644"
		dobin logextract striplog
	fi
}

pkg_postinst() {
	elog ""
	elog "This version of gpsd has broken support for the SuperStarII"
	elog "chipset which is currently disabled."
	elog ""
	elog "Other than the above, all default devices are enabled, and all"
	elog "optional devices and formats are controlled via USE flags."
	elog ""
	elog "Recent versions of udev (>=udev-115 or so) should have correct"
	elog "usb device detection and startup of gpsd (ie, without hotplug)."
	elog ""
	elog "Certain GPS devices also require the corresponding kernel options"
	elog "to be enabled, such as USB_SERIAL_GARMIN, or a USB serial driver"
	elog "for an adapter such as those that come with Deluo GPS units (eg,"
	elog "USB_SERIAL_PL2303). Straight serial devices should always work,"
	elog "even without udev/hotplug support."
	elog ""
	elog "Note: the supplied gpsd udev rules are now device-specific, so"
	elog "if your device isn't detected correctly, please use lsusb or"
	elog "another suitable tool to determine the proper device IDs and"
	elog "use the commented rules to fill in the blanks for your device."
	elog ""
	elog "Please see this post about the new capabilities database:"
	elog ""
	elog "http://lists.berlios.de/pipermail/gpsd-dev/2009-January/006333.html"
	elog ""
	elog "on current hardware, adding new hardware, etc.  Read the above"
	elog "and the INSTALL doc for more information on supported hardware,"
	elog "and make sure udev has the right group permissions set on the"
	elog "devices if using USB (it should Do The Right Thing (TM))..."
	elog ""
}
