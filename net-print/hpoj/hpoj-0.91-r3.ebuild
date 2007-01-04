# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpoj/hpoj-0.91-r3.ebuild,v 1.14 2007/01/04 16:55:43 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils qt3 autotools

DESCRIPTION="HP OfficeJet Linux driver"
HOMEPAGE="http://hpoj.sourceforge.net/"
SRC_URI="mirror://sourceforge/hpoj/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE="ssl scanner qt3 X snmp cups usb"

DEPEND="qt3?	  ( $(qt_min_version 3.1) )
	ssl?	 ( >=dev-libs/openssl-0.9.6h )
	scanner? ( >=media-gfx/sane-backends-1.0.9 )
	scanner? ( || ( X? ( >=media-gfx/xsane-0.89 ) >=media-gfx/sane-frontends-1.0.9 ) )
	snmp?	 ( net-analyzer/net-snmp )
	cups?	 ( >=net-print/cups-1.1.18-r2 )
	usb?	 ( >=dev-libs/libusb-0.1.10a sys-apps/hotplug )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	epatch ${FILESDIR}/udev.patch
	epatch ${FILESDIR}/${P}-kernel26.patch

	use snmp \
	&& myconf="${myconf} --with-snmp=/usr" \
	|| myconf="${myconf} --without-snmp"

	use cups \
	&& myconf="${myconf} --with-cups-backend=/usr" \
	|| myconf="${myconf} --without-cups"

	# xojpanel
	use qt3 \
	&& myconf="${myconf} --with-qt=/usr/qt/3" \
	|| myconf="${myconf} --without-qt"

	use scanner \
	&& myconf="${myconf} --with-sane-packend=/usr" \
	|| myconf="${myconf} --without-sane"

	econf ${myconf} || die "econf failed"
	emake || die "compilation failed"
}

src_install() {
	cd apps/cmdline
	dobin ptal-print hpojip-test ptal-connect ptal-device ptal-devid ptal-hp ptal-pml
	cd ../../doc
	dohtml *html
	cd ..
	dodoc COPYING LICENSE LICENSE.OpenSSL README
	use qt3 && dobin apps/xojpanel/xojpanel
	dodir /usr/include
	insinto /usr/include
	doins include/hpojip.h include/ptal.h
	cd lib
	dolib.so hpojip/libhpojip.so*
	dolib.so ptal/libptal.so*
	dodir /usr/lib/sane
	insinto /usr/lib/sane
	doins sane/libsane-hpoj.so*
	dodir /usr/lib/ghostscript/filt \
	/usr/lib/ghostscript/filt/bjc600 \
	/usr/lib/ghostscript/filt/bjc600.1 \
	/usr/lib/ghostscript/filt/bjc600.16 \
	/usr/lib/ghostscript/filt/bjc600.24 \
	/usr/lib/ghostscript/filt/bjc600.24.3 \
	/usr/lib/ghostscript/filt/bjc600.32 \
	/usr/lib/ghostscript/filt/bjc600.8 \
	/usr/lib/ghostscript/filt/bjc600.8.1 \
	/usr/lib/ghostscript/filt/bjt600.32 \
	/usr/lib/ghostscript/filt/direct \
	/usr/lib/ghostscript/filt/gsif \
	/usr/lib/ghostscript/filt/indirect \
	/usr/lib/ghostscript/filt
	cd ..
	dosbin apps/cmdline/ptal-photod apps/cmdline/ptal-printd mlcd/ptal-mlcd scripts/ptal-cups
	exeinto /usr/sbin
	doexe scripts/ptal-init
	dodir /usr/lib/cups/backend
	dosym /usr/sbin/ptal-cups /usr/lib/cups/backend/ptal
	exeinto /etc/init.d
	newexe ${FILESDIR}/hpoj.init hpoj
}

pkg_postinst() {
	echo
	einfo "You might want to emerge sys-fs/mtools for photo-card support."
	echo
	einfo "You might want to emerge net-print/hpijs for better printing quality."
	echo
	einfo "Before starting hpoj you have to set it up with 'ptal-init setup'"
	echo
	einfo "If you are upgrading from a previous version, re-run ptal-init setup"
	einfo "as the format of	the connection has changed again and your previously"
	einfo "installed hpoj-device will not be recognized."
	echo
	einfo "net-print/hpoj is deprecated, please use net-print/hplip"
	echo
}
