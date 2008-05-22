# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-2.8.5.ebuild,v 1.2 2008/05/22 07:36:56 corsair Exp $

inherit eutils linux-info

DESCRIPTION="HP Linux Imaging and Printing System. Includes net-print/hpijs, scanner drivers and service tools."
HOMEPAGE="http://hplip.sourceforge.net/"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

IUSE="X cupsddk dbus doc fax minimal parport ppds scanner snmp"

DEPEND="!net-print/hpijs
	!net-print/hpoj
	virtual/ghostscript
	>=media-libs/jpeg-6b
	>=net-print/foomatic-filters-3.0.20070501
	!minimal? (
		>=net-print/cups-1.2
		dev-libs/libusb
		cupsddk? ( net-print/cupsddk )
		dbus? ( >=sys-apps/dbus-1.0.0 )
		scanner? ( >=media-gfx/sane-backends-1.0.19-r1 )
		snmp? (
			net-analyzer/net-snmp
			dev-libs/openssl
		)
	)"

RDEPEND="${DEPEND}
	!minimal? (
		!<sys-fs/udev-114
		scanner? (
			dev-python/imaging
			X? ( >=media-gfx/xsane-0.89 )
			!X? ( >=media-gfx/sane-frontends-1.0.9 )
		)
		X? (
			>=dev-python/PyQt-3.14
			dbus? ( >=dev-python/dbus-python-0.80 )
			fax? ( dev-python/reportlab )
		)
	)"

CONFIG_CHECK="PARPORT PPDEV"
ERROR_PARPORT="Please make sure parallel port support is enabled in your kernel (PARPORT and PPDEV)."

pkg_setup() {
	if ! use ppds && ! use cupsddk; then
		ewarn "Installing neither static (USE=-ppds) nor dynamic (USE=-cupsddk) PPD files,"
		ewarn "which is probably not what you want. You will almost certainly not be able to "
		ewarn "print (recommended: USE=\"cupsddk -ppds\")."
	fi
	if use minimal ; then
		ewarn "Installing hpijs driver only, make sure you know what you are doing."
	else
		use parport && linux-info_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:\$(doc_DATA)::" Makefile.in || die "Patching Makefile.in failed"
	sed -i -e "s/'skipstone']/'skipstone', 'epiphany']/" \
		-e "s/'skipstone': ''}/'skipstone': '', 'epiphany': '--new-window'}/" \
		base/utils.py  || die "Patching base/utils.py failed"

	# bug 98428
	sed -i -e "s:/usr/bin/env python:/usr/bin/python:g" hpssd.py || die "Patching hpssd.py failed"

	# Force recognition of Gentoo distro by hp-check
	sed -i \
		-e "s:file('/etc/issue', 'r').read():'Gentoo':" \
		installer/core_install.py || die "sed core_install.py"

	# Replace udev rules, see bug #197726.
	rm data/rules/55-hpmud.rules
	cp "${FILESDIR}"/70-hpmud.rules data/rules
	sed -i -e "s/55-hpmud.rules/70-hpmud.rules/g" Makefile.* */*.html */*/*.html

	# Use system foomatic-rip instead of foomatic-rip-hplip
	sed -i -e 's/foomatic-rip-hplip/foomatic-rip/' ppd/*.ppd || die "sed failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-cups11-build \
		--with-cupsbackenddir=$(cups-config --serverbin)/backend \
		--with-cupsfilterdir=$(cups-config --serverbin)/filter \
		--disable-foomatic-rip-hplip-install \
		$(use_enable X gui-build) \
		$(use_enable doc doc-build) \
		$(use_enable cupsddk foomatic-drv-install) \
		$(use_enable dbus dbus-build) \
		$(use_enable fax fax-build) \
		$(use_enable minimal hpijs-only-build) \
		$(use_enable parport pp-build) \
		$(use_enable ppds foomatic-ppd-install) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
		|| die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"/etc/sane.d/dll.conf

	# bug 106035
	use X || rm -Rf "${D}"/usr/share/applications

	use minimal && rm -rf "${D}"/usr/lib
}

pkg_preinst() {
	# avoid collisions with cups-1.2 compat symlinks
	if [ -e "${ROOT}"/usr/lib/cups/backend/hp ] && [ -e "${ROOT}"/usr/libexec/cups/backend/hp ]; then
		rm -f "${ROOT}"/usr/libexec/cups/backend/hp{,fax};
	fi
}

pkg_postinst() {
	elog "You should run hp-setup as root if you are installing hplip for the first time, and may also"
	elog "need to run it if you are upgrading from an earlier version."
	elog
	elog "If your device is connected using USB, users will need to be in the lp group to access it."
	elog
	elog "This release doesn't use an init script anymore, so you should probably do a"
	elog "'rc-update del hplip' if you are updating from an old version."
}
