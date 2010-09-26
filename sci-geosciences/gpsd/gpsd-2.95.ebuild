# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsd/gpsd-2.95.ebuild,v 1.1 2010/09/26 13:36:50 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit python base

DESCRIPTION="GPS daemon and library to support USB/serial GPS devices and various GPS/mapping clients."
HOMEPAGE="http://gpsd.berlios.de/"
SRC_URI="mirror://berlios/gpsd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

GPSD_PROTOCOLS="ashtech aivdm clientdebug earthmate evermore fv18 garmin
	garmintxt gpsclock itrax mtk3301 nmea ntrip navcom oceanserver
	oldstyle oncore rtcm104v2 rtcm104v3 sirf superstar2 timing tsip
	tripmate tnt ubx"
for protocol in ${GPSD_PROTOCOLS}; do
	IUSE_GPSD_PROTOCOLS+=" gpsd_protocols_${protocol}"
done
IUSE="${IUSE_GPSD_PROTOCOLS} dbus ipv6 ntp qt4"

# those harddeps are de-facto automagicall
RDEPEND="
	dev-python/pygtk
	sys-libs/ncurses
	virtual/libusb:1
	dbus? (
		sys-apps/dbus
		dev-libs/dbus-glib
	)
	ntp? ( net-misc/ntp )
	qt4? ( x11-libs/qt-gui )
"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2

	# Run the gpsd daemon as gpsd and group uucp
	enewuser gpsd -1 -1 -1 "uucp"
}

src_configure() {
	local myopts

	# enable specified protocols
	for protocol in ${GPSD_PROTOCOLS}; do
		myopts+=" $(use_enable gpsd_protocols_${protocol} ${protocol})"
	done

	# --disable-bluetooth: considered experimental -> disable
	# hack to make it not generate docs on the fly
	WITH_XSLTPROC=no WITH_XMLTO=no \
	econf \
		--disable-dependency-tracking \
		--disable-bluetooth \
		--disable-static \
		--enable-libgpsmm \
		--enable-gpsd-user=gpsd \
		--enable-gpsd-group=uucp \
		$(use_enable dbus) \
		$(use_enable ipv6) \
		$(use_enable ntp ntpshm) \
		$(use_enable ntp pps) \
		$(use_enable qt4 libQgpsmm) \
		${myopts}
}

src_install() {
	base_src_install

	newconfd "${FILESDIR}"/gpsd.conf-2 gpsd || die
	newinitd "${FILESDIR}"/gpsd.init-2 gpsd || die
}
