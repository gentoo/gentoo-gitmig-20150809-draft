# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-2.7.12.ebuild,v 1.4 2008/01/14 07:49:41 calchan Exp $

inherit eutils linux-info

DESCRIPTION="HP Linux Imaging and Printing System. Includes net-print/hpijs, scanner drivers and service tools."
HOMEPAGE="http://hplip.sourceforge.net/"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="X doc fax minimal parport ppds scanner snmp"

DEPEND="!net-print/hpijs
	!net-print/hpoj
	virtual/ghostscript
	>=media-libs/jpeg-6b
	net-print/foomatic-filters
	!minimal? (
		>=net-print/cups-1.2
		dev-libs/libusb
		scanner? ( >=media-gfx/sane-backends-1.0.9 )
		snmp? (
			net-analyzer/net-snmp
			dev-libs/openssl
		)
	)"

RDEPEND="${DEPEND}
	!minimal? (
		!<sys-fs/udev-114
		fax? ( dev-python/reportlab )
		scanner? (
			dev-python/imaging
			X? ( >=media-gfx/xsane-0.89 )
			!X? ( >=media-gfx/sane-frontends-1.0.9 )
		)
		X? ( >=dev-python/PyQt-3.14 )
	)"

CONFIG_CHECK="PARPORT"
ERROR_PARPORT="Please make sure Device Drivers -> Parallel port support is enabled in your kernel"

pkg_setup() {
	if ! use ppds ; then
		ewarn "Not installing built-in PPD files, which is probably not what you want."
		ewarn "You need USE=ppds if you want to install them."
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
}

src_compile() {
	econf \
		--disable-cups11-build \
		--with-cupsbackenddir=$(cups-config --serverbin)/backend \
		$(use_enable minimal hpijs-only-build) \
		$(use_enable doc doc-build) \
		$(use_enable snmp network-build) \
		$(use_enable parport pp-build) \
		$(use_enable scanner scan-build) \
		$(use_enable X gui-build) \
		$(use_enable fax fax-build) \
		$(use_enable ppds foomatic-ppd-install) \
		--disable-foomatic-xml-install \
		|| die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	# bug 106035
	use X || rm -Rf "${D}"/usr/share/applications

	use minimal && rm -rf "${D}"/usr/lib
}

pkg_preinst() {
	# avoid collisions with cups-1.2 compat symlinks
	if [ -e "${ROOT}"/usr/lib/cups/backend/hp ] && [ -e "${ROOT}"/usr/libexec/cups/backend/hp ]; then
		rm -f "${ROOT}"/usr/libexec/cups/backend/hp{,fax};
	fi

	# try to be very conservative as to when we screw around with config files
	use minimal && return 0
	use scanner || return 0
	[[ ! -e ${ROOT}/etc/sane.d/dll.conf ]] && return 0
	grep -qs '\<hpaio\>' "${ROOT}"/etc/sane.d/dll.conf && return 0

	cp "${ROOT}"/etc/sane.d/dll.conf "${T}"/dll.conf || return 1
	echo hpaio >> "${T}"/dll.conf
	insinto /etc/sane.d
	doins "${T}"/dll.conf
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
