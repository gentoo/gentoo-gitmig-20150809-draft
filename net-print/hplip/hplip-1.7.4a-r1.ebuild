# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-1.7.4a-r1.ebuild,v 1.3 2007/06/07 14:39:26 corsair Exp $

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
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE="cups fax foomaticdb parport ppds qt3 scanner snmp X"

DEPEND="!net-print/hpijs
	!net-print/hpoj
	dev-libs/openssl
	virtual/ghostscript
	>=media-libs/jpeg-6b
	net-print/cups
	dev-libs/libusb
	>=dev-lang/python-2.2
	net-print/foomatic-filters
	fax? ( >=dev-lang/python-2.3
		dev-python/reportlab )
	foomaticdb? ( net-print/foomatic-db-engine )
	snmp? ( net-analyzer/net-snmp )
	qt3? ( >=dev-python/PyQt-3.11 =x11-libs/qt-3* )
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
	)"
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
		$(use_enable cups cups-install) \
		$(use_enable fax fax-build) \
		$(use_enable parport pp-build) \
		$(use_enable ppds foomatic-install) \
		$(use_enable qt3 gui-build) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
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

	# Fix a symlink collision, see bug #172341
	rm -f ${D}/usr/share/cups/model/foomatic-ppds
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

pkg_postinst() {
	if ! use qt3 ; then
		elog "You need to enable the qt3 useflag to use the GUI"
	fi
}
