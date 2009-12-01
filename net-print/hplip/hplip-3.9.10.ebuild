# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-3.9.10.ebuild,v 1.4 2009/12/01 11:18:46 flameeyes Exp $

EAPI="2"

inherit fdo-mime linux-info python autotools

DESCRIPTION="HP Linux Imaging and Printing System. Includes printer, scanner, fax drivers and service tools."
HOMEPAGE="http://hplipopensource.com/hplip-web/index.html"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="doc fax gtk +hpcups hpijs libnotify minimal -new-hpcups parport policykit qt3 qt4 scanner snmp static-ppds -udev-acl zeroconf"

# Note : libusb-compat untested (calchan 20090516)

COMMON_DEPEND="
	virtual/ghostscript
	media-libs/jpeg
	hpijs? ( >=net-print/foomatic-filters-3.0.20080507[cups] )
	!static-ppds? ( || ( >=net-print/cups-1.4.0 net-print/cupsddk ) )
	udev-acl? ( >=sys-fs/udev-145[extras] )
	!minimal? (
		!zeroconf? ( net-print/cups )
		zeroconf? ( || ( net-print/cups[avahi] net-print/cups[zeroconf] ) )
		virtual/libusb:0
		>=dev-lang/python-2.4.4[threads,xml]
		scanner? ( >=media-gfx/sane-backends-1.0.19-r1 )
		snmp? (
			net-analyzer/net-snmp
			dev-libs/openssl
		)
	)"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	!minimal? (
		kernel_linux? ( >=sys-fs/udev-114 )
		scanner? (
			dev-python/imaging
			gtk? ( media-gfx/xsane )
			!gtk? ( media-gfx/sane-frontends )
		)
		fax? (
			dev-python/reportlab
			sys-apps/dbus
			dev-python/dbus-python
		)
		qt3? ( !qt4? (
			dev-python/PyQt
		) )
		qt4? (
			dev-python/PyQt4[dbus,X]
			dev-python/pygobject
			libnotify? (
				dev-python/notify-python
			)
			policykit? (
				sys-auth/policykit
			)
		)
	)"

CONFIG_CHECK="~PARPORT ~PPDEV"
ERROR_PARPORT="Please make sure parallel port support is enabled in your kernel (PARPORT and PPDEV)."

pkg_setup() {
	! use qt3 && ! use qt4 && ewarn "You need USE=qt4 or USE=qt3 for the hplip GUI."

	use scanner && ! use gtk && ewarn "You need USE=gtk for the scanner GUI."

	if ! use hpcups && ! use hpijs ; then
		ewarn "Installing neither hpcups (USE=-hpcups) nor hpijs (USE=-hpijs) driver,"
		ewarn "which is probably not what you want."
		ewarn "You will almost certainly not be able to print."
		ewarn "Recommended USE flags: USE=\"hpcups -hpijs\")."
	fi

	if use minimal ; then
		ewarn "Installing driver portions only, make sure you know what you are doing."
		ewarn "Depending on the USE flags set for hpcups and/or hpijs the appropiate"
		ewarn "drivers are installed."
	else
		use parport && linux-info_pkg_setup
	fi
}

src_prepare() {
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/452113
	epatch "${FILESDIR}"/${P}-desktop.patch
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/482674
	epatch "${FILESDIR}"/${P}-browser.patch

	# bug 98428
	sed -i -e "s:/usr/bin/env python:/usr/bin/python:g" hpssd.py || die "Sed hpssd.py failed"

	# Force recognition of Gentoo distro by hp-check
	sed -i \
		-e "s:file('/etc/issue', 'r').read():'Gentoo':" \
		installer/core_install.py || die "Sed installer/core_install.py failed"

	# SYSFS deprecated - https://bugs.launchpad.net/hplip/+bug/346390
	sed -i -e "s/SYSFS/ATTRS/g" -e "s/sysfs/attrs/g" data/rules/56-hpmud_support.rules \
		data/rules/55-hpmud.rules || die "Sed 55-hpmud.rules 56-hpmud_support.rules failed"

	sed -i \
		-e s:/usr/lib/cups/driver:$(cups-config --serverbin)/driver:g \
		installer/core_install.py || die "Sed installer/core_install.py failed"

	# Use system foomatic-rip instead of foomatic-rip-hplip
	local i
	for i in ppd/{hpcups,hpijs}/*.ppd.gz
	do
		rm -f ${i}.temp
		gunzip -c ${i} | sed 's/foomatic-rip-hplip/foomatic-rip/g' | gzip > ${i}.temp || die "Sed *.ppd.gz failed"
		mv ${i}.temp ${i}
	done

	local qt_ver
	if use qt3 || use qt4 ; then
		use qt3 && qt_ver="3"
		use qt4 && qt_ver="4"
		sed -i \
			-e "s/%s --force-startup/%s --force-startup --qt${qt_ver}/" \
			-e "s/'--force-startup'/'--force-startup', '--qt${qt_ver}'/" \
			base/device.py || die "Sed base/device.py failed"
		sed -i \
			-e "s/Exec=hp-systray/Exec=hp-systray --qt${qt_ver}/" \
			hplip-systray.desktop.in || die "Sed hplip-systray.desktop.in failed"
	fi

	# htmldocs are not installed under docdir/html
	# the following sed enables --htmldir configure switch in src_configure
	if use doc ; then
			sed -i -e 's/www\([0-9]\)dir = $(docdir)/www\1dir = $(htmldir)/g' Makefile.am || die "Sed Makefile.am failed"
	fi

	eautoreconf
}

src_configure() {
	local gui_build myconf drv_build minimal_build

	if use qt3 || use qt4 ; then
		gui_build="--enable-gui-build"
		if use qt4 ; then
			gui_build="${gui_build} --enable-qt4 --disable-qt3"
			if use policykit ; then
				myconf="--enable-policykit"
			else
				myconf="--disable-policykit"
			fi
		else
			use qt3 && gui_build="${gui_build} --enable-qt3 --disable-qt4"
		fi
	else
		gui_build="--disable-gui-build --disable-qt3 --disable-qt4"
	fi

	if use fax || use qt4 ; then
		myconf="${myconf} --enable-dbus-build"
	else
		myconf="${myconf} --disable-dbus-build"
	fi

	if use hpcups ; then
		drv_build="$(use_enable hpcups hpcups-install)"
		if use static-ppds ; then
			drv_build="${drv_build} --enable-cups-ppd-install"
			drv_build="${drv_build} --disable-cups-drv-install"
		else
			drv_build="${drv_build} --enable-cups-drv-install"
			drv_build="${drv_build} --disable-cups-ppd-install"
		fi
	else
		drv_build="--disable-hpcups-install --disable-cups-drv-install"
		drv_build="${drv_build} --disable-cups-ppd-install"
	fi

	if use hpijs ; then
		drv_build="${drv_build} $(use_enable hpijs hpijs-install)"
		if use static-ppds ; then
			drv_build="${drv_build} --enable-foomatic-ppd-install"
			drv_build="${drv_build} --disable-foomatic-drv-install"
		else
			drv_build="${drv_build} --enable-foomatic-drv-install"
			drv_build="${drv_build} --disable-foomatic-ppd-install"
		fi
	else
		drv_build="${drv_build} --disable-hpijs-install"
		drv_build="${drv_build} --disable-foomatic-drv-install"
		drv_build="${drv_build} --disable-foomatic-ppd-install"
	fi

	if use minimal ; then
		if use hpijs ; then
			minimal_build="--enable-hpijs-only-build"
		else
			minimal_build="--disable-hpijs-only-build"
		fi
		if use hpcups ; then
			minimal_build="${minimal_build} --enable-hpcups-only-build"
		else
			minimal_build="${minimal_build} --disable-hpcups-only-build"
		fi
	fi

	econf \
		--disable-dependency-tracking \
		--disable-cups11-build \
		--disable-lite-build \
		--disable-foomatic-rip-hplip-install \
		--disable-shadow-build \
		--with-cupsbackenddir=$(cups-config --serverbin)/backend \
		--with-cupsfilterdir=$(cups-config --serverbin)/filter \
		--htmldir=/usr/share/doc/${P}/html \
		${gui_build} \
		${myconf} \
		${drv_build} \
		${minimal_build} \
		$(use_enable new-hpcups new-hpcups) \
		$(use_enable doc doc-build) \
		$(use_enable fax fax-build) \
		$(use_enable parport pp-build) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
		$(use_enable udev-acl udev-acl-rules)
}

src_install() {
	emake DESTDIR="${D}" install || die "Emake install failed"

	# Bug #201023
	rm -f "${D}"/etc/sane.d/dll.conf

	# kde3 autostart hack
	if [[ -d /usr/kde/3.5/share/autostart ]] && use !minimal ; then
		insinto /usr/kde/3.5/share/autostart
		doins hplip-systray.desktop
	fi
}

pkg_preinst() {
	# avoid collisions with cups-1.2 compat symlinks
	if [ -e "${ROOT}"/usr/lib/cups/backend/hp ] && [ -e "${ROOT}"/usr/libexec/cups/backend/hp ] ; then
		rm "${ROOT}"/usr/libexec/cups/backend/hp{,fax}
	fi
}

pkg_postinst() {
	use !minimal && python_mod_optimize /usr/share/${PN}
	fdo-mime_desktop_database_update

	elog "You should run hp-setup as root if you are installing hplip for the first time,"
	elog "and may also need to run it if you are upgrading from an earlier version."
	elog
	elog "If your device is connected using USB, users will need to be in the lp group to"
	elog "access it."
	elog
	elog "This release doesn't use an init script anymore, so you should probably do a"
	elog "'rc-update del hplip' if you are updating from an old version."
	elog
	elog "Starting with versions of hplip >=3.9.8 mDNS is the default network search"
	elog "mechanism. To make use of it you need to activate the zeroconf flag. If you"
	elog "prefer the SLP method you have to choose this when configuring the device."
}

pkg_postrm() {
	use !minimal && python_mod_cleanup /usr/share/${PN}
	fdo-mime_desktop_database_update
}
