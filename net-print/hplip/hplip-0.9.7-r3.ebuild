# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-0.9.7-r3.ebuild,v 1.7 2006/04/23 17:09:28 vanquirius Exp $

inherit eutils

DB_V=1.5-20051126
DESCRIPTION="HP Linux Imaging and Printing System. Includes net-print/hpijs, scanner drivers and service tools."
HOMEPAGE="http://hpinkjet.sourceforge.net/"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz
	mirror://sourceforge/hpinkjet/${P}-2.patch
	foomaticdb? ( mirror://gentoo/foomatic-db-hpijs-${DB_V}.tar.gz )"
	#http://www.linuxprinting.org/download/foomatic/foomatic-db-hpijs-${DB_V}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="foomaticdb snmp X qt ppds scanner cups usb"

DEPEND="dev-lang/python
	snmp? ( >=net-analyzer/net-snmp-5.0.9 )
	!net-print/hpijs
	!net-print/hpoj"

RDEPEND="virtual/ghostscript
	>=dev-lang/python-2.2.0
	scanner? (
		>=media-gfx/sane-backends-1.0.9
		|| (
			X? ( >=media-gfx/xsane-0.89 )
			>=media-gfx/sane-frontends-1.0.9
		)
	)
	qt? ( >=dev-python/PyQt-3.11 =x11-libs/qt-3* )
	usb? ( >=dev-libs/libusb-0.1.10a sys-apps/hotplug )
	foomaticdb? ( net-print/foomatic )
	net-print/cups
	>=net-print/foomatic-filters-3.0.2
	${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug 116952
	epatch "${DISTDIR}"/${P}-2.patch

	sed -i -e "s:(uint32_t)0xff000000) >> 24))):(uint32_t)0xff000000) >> 24):" \
		"${S}"/scan/sane/mfpdtf.h

	# bug 98428
	sed -i -e "s:/usr/bin/env python:/usr/bin/python:g" \
		"${S}"/hpssd.py
}
src_compile() {
	myconf="${myconf} --disable-cups-install --disable-foomatic-install"

	use snmp || myconf="${myconf} --disable-network-build"

	econf ${myconf} || die "Error: econf failed!"
	emake || die "Error: emake failed!"
}


src_install() {
	make DESTDIR="${D}" install

	newinitd "${FILESDIR}"/hplip.init.d hplip

	if use scanner; then
		insinto /etc/sane.d
		echo "hpaio" > dll.conf
		doins dll.conf

		dodir /usr/lib/sane
		dosym /usr/lib/libsane-hpaio.la /usr/lib/sane/libsane-hpaio.la
		dosym /usr/lib/libsane-hpaio.so /usr/lib/sane/libsane-hpaio.so
		dosym /usr/lib/libsane-hpaio.so.1 /usr/lib/sane/libsane-hpaio.so.1
		dosym /usr/lib/libsane-hpaio.so.1.0.0 /usr/lib/sane/libsane-hpaio.so.1.0.0
	else
		rm -f "${D}"/usr/lib/libsane-hpaio.la
		rm -f "${D}"/usr/lib/libsane-hpaio.so
		rm -f "${D}"/usr/lib/libsane-hpaio.so.1
		rm -f "${D}"/usr/lib/libsane-hpaio.so.1.0.0
	fi

	# bug 106035
	if ! use qt ; then
		rm -f "${D}"/usr/bin/hp-print
		rm -f "${D}"/usr/bin/hp-toolbox
		rm -f "${D}"/usr/share/hplip/print
		rm -f "${D}"/usr/share/hplip/toolbox
		rm -f "${D}"/usr/share/hplip/data/hplip.desktop
		rm -f "${D}"/usr/share/applications/hplip.desktop
	fi

	if use ppds; then
		dodir /usr/share
		mv "${S}"/prnt/hpijs/ppd "${D}"/usr/share
	fi

	if use cups && use ppds ; then
		dodir /usr/share/cups/model
		dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
	fi

	[ -e /usr/bin/foomatic-rip ] && rm -f "${D}"/usr/bin/foomatic-rip

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		econf || die "econf failed"
		rm -fR data-generators/hpijs-rss
		make || die
		make DESTDIR="${D}" install || die
	fi

	# desktop entry, bug 122758
	if use qt; then
		dodir /usr/share/applications
		mv "${D}"/usr/share/hplip/data/hplip.desktop \
		"${D}"/usr/share/applications
	fi
}
