# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-1.7.3.ebuild,v 1.2 2007/03/27 09:24:53 genstef Exp $

inherit eutils

DB_V=20060720
DESCRIPTION="HP Linux Imaging and Printing System. Includes net-print/hpijs, scanner drivers and service tools."
HOMEPAGE="http://hplip.sourceforge.net/"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz
	foomaticdb? (
		http://gentooexperimental.org/~genstef/dist/foomatic-db-hpijs-${DB_V}.tar.gz
		http://www.linuxprinting.org/download/foomatic/foomatic-db-hpijs-${DB_V}.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cups foomaticdb snmp qt3 ppds scanner X"

DEPEND=">=dev-lang/python-2.2.0
	snmp? ( >=net-analyzer/net-snmp-5.0.9 )
	!net-print/hpijs
	!net-print/hpoj
	virtual/ghostscript
	scanner? (
		>=media-gfx/sane-backends-1.0.9
		X? ( || (
			>=media-gfx/xsane-0.89
			>=media-gfx/sane-frontends-1.0.9
			) )
		!X? ( || (
			>=media-gfx/sane-frontends-1.0.9
			>=media-gfx/xsane-0.89
			) )
	)
	qt3? ( >=dev-python/PyQt-3.11 =x11-libs/qt-3* )
	>=dev-libs/libusb-0.1.10a
	sys-apps/hotplug-base
	net-print/cups
	foomaticdb? ( net-print/foomatic-db-engine )
	>=net-print/foomatic-filters-3.0.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	# avoid collisions with cups-1.2 compat symlinks
	if [ -e ${ROOT}/usr/lib/cups/backend/hp ] && [ -e ${ROOT}/usr/libexec/cups/backend/hp ]; then
		rm -f ${ROOT}/usr/libexec/cups/backend/hp{,fax};
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug 98428
	sed -i -e "s:/usr/bin/env python:/usr/bin/python:g" \
		hpssd.py
}
src_compile() {
	econf \
		$(use_enable snmp network-build) \
		$(use_enable cups cups-install) \
		$(use_enable ppds foomatic-install) \
		|| die "econf failed"
	emake || die "emake failed"

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		econf || die "econf failed"
		rm -fR data-generators/hpijs-rss
		emake || die "emake failed"
	fi
}


src_install() {
	# cups-1.2 installation paths, make sure that the .desktop is installed
	sed -i -e "s:/usr/lib/cups:$(cups-config --serverbin):" \
		-e 's:\(ICON_FILE = \).*:\1hplip.desktop:' \
		-e 's:\(ICON_PATH = \).*:\1/usr/share/applications:' \
		Makefile

	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/hplip.init.d hplip

	if use scanner; then
		dodir /usr/$(get_libdir)/sane
		for i in libsane-hpaio.{la,so{,.1{,.0.0}}}; do
			dosym /usr/$(get_libdir)/${i} /usr/$(get_libdir)/sane/${i}; done
	else
		rm -f "${D}"/usr/$(get_libdir)/libsane-hpaio.{la,so{,.1{,.0.0}}}
		rm -f "${D}"/etc/sane.d/dll.conf
	fi

	# bug 106035
	if ! use qt3 ; then
		rm -f "${D}"/usr/{bin/hp-,share/hplip/}{print,toolbox}
		rm -f "${D}"/usr/share/applications/hplip.desktop
		rm -f "${D}"/usr/lib/menu/hplip
	fi

	rm -rf ${D}/$(cups-config --serverbin)/filter ${D}/usr/bin/foomatic-rip

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
}

pkg_preinst() {
	if use scanner; then
		insinto /etc/sane.d
		[ -e /etc/sane.d/dll.conf ] && cp /etc/sane.d/dll.conf .
		[ -e ${ROOT}/etc/sane.d/dll.conf ] && cp ${ROOT}/etc/sane.d/dll.conf .
		grep -q hpaio dll.conf || echo hpaio >> dll.conf
		doins dll.conf
	fi
}
