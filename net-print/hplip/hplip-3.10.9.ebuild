# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-3.10.9.ebuild,v 1.2 2010/10/06 18:47:21 ssuominen Exp $

EAPI=2

PYTHON_DEPEND="!minimal? 2"
PYTHON_USE_WITH="threads xml"
PYTHON_USE_WITH_OPT="!minimal"

inherit fdo-mime linux-info python autotools

DESCRIPTION="HP Linux Imaging and Printing System. Includes printer, scanner, fax drivers and service tools."
HOMEPAGE="http://hplipopensource.com/hplip-web/index.html"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

# zeroconf does not work properly with >=cups-1.4. thus support for it is also disabled in hplip.
IUSE="doc fax +hpcups hpijs kde libnotify minimal parport policykit qt4 scanner snmp static-ppds -udev-acl X"

COMMON_DEPEND="
	media-libs/jpeg
	hpijs? ( >=net-print/foomatic-filters-3.0.20080507[cups] )
	udev-acl? ( >=sys-fs/udev-145[extras] )
	snmp? (
		net-analyzer/net-snmp
		dev-libs/openssl
	)
	!minimal? (
		net-print/cups
		virtual/libusb:0
		scanner? ( >=media-gfx/sane-backends-1.0.19-r1 )
		fax? ( sys-apps/dbus )
	)"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	>=app-text/ghostscript-gpl-8.71-r3
	!static-ppds? ( || ( >=net-print/cups-1.4.0 net-print/cupsddk ) )
	!minimal? (
		dev-python/pygobject
		kernel_linux? ( >=sys-fs/udev-114 )
		scanner? (
			dev-python/imaging
			X? ( || (
				kde? ( kde-misc/skanlite )
				media-gfx/xsane
				media-gfx/sane-frontends
			) )
		)
		fax? (
			dev-python/reportlab
			dev-python/dbus-python
		)
		qt4? (
			dev-python/PyQt4[dbus,X]
			libnotify? (
				dev-python/notify-python
			)
			policykit? (
				sys-auth/polkit
			)
		)
	)"

CONFIG_CHECK="~PARPORT ~PPDEV"
ERROR_PARPORT="Please make sure parallel port support is enabled in your kernel (PARPORT and PPDEV)."

pkg_setup() {
	if ! use minimal; then
		python_set_active_version 2
		python_pkg_setup
	fi

	! use qt4 && ewarn "You need USE=qt4 for the hplip GUI."

	use scanner && ! use X && ewarn "You need USE=X for the scanner GUI."

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
	python_convert_shebangs -q -r 2 .

	# Do not install desktop files if there is no gui
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/452113
	epatch "${FILESDIR}"/${PN}-3.9.10-desktop.patch

	# Browser detection through xdg-open
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/482674
	epatch "${FILESDIR}"/${PN}-3.9.10-browser.patch

	# Use cups-config when checking for cupsddk
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/483136
	epatch "${FILESDIR}"/${PN}-3.9.12-cupsddk.patch

	# Htmldocs are not installed under docdir/html so enable htmldir configure switch
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/483217
	epatch "${FILESDIR}"/${PN}-3.9.10-htmldir.patch

	# Increase systray check timeout for slower machines
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/335662
	epatch "${FILESDIR}"/${PN}-3.9.12-systray.patch

	# SYSFS deprecated but kept upstream for compatibility reasons
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/346390
	epatch "${FILESDIR}"/${PN}-3.10.5-udev-attrs.patch

	# Force recognition of Gentoo distro by hp-check
	sed -i \
		-e "s:file('/etc/issue', 'r').read():'Gentoo':" \
		installer/core_install.py || die

	# Use system foomatic-rip for hpijs driver instead of foomatic-rip-hplip
	# The hpcups driver does not use foomatic-rip
	local i
	for i in ppd/hpijs/*.ppd.gz
	do
		rm -f ${i}.temp
		gunzip -c ${i} | sed 's/foomatic-rip-hplip/foomatic-rip/g' | gzip > ${i}.temp || die
		mv ${i}.temp ${i}
	done

	eautoreconf
}

src_configure() {
	local gui_build myconf drv_build minimal_build

	if use qt4 ; then
		gui_build="--enable-gui-build --enable-qt4 --disable-qt3"
		if use policykit ; then
			myconf="--enable-policykit"
		else
			myconf="--disable-policykit"
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
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		${gui_build} \
		${myconf} \
		${drv_build} \
		${minimal_build} \
		$(use_enable doc doc-build) \
		$(use_enable fax fax-build) \
		$(use_enable parport pp-build) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
		$(use_enable udev-acl udev-acl-rules)
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Installed by sane-backends
	# Gentoo Bug: #201023
	rm -f "${D}"/etc/sane.d/dll.conf || die
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
	elog "Starting with versions of hplip >=3.9.8 mDNS is the default network search"
	elog "mechanism. To make use of it you need to activate the zeroconf flag on cups."
	elog "If you prefer the SLP method you have to choose this when configuring the"
	elog "device."
	elog "Note: For cups-1.4.x SLP is the only supported method as mDNS (zeroconf) is not"
	elog "available here."

}

pkg_postrm() {
	use !minimal && python_mod_cleanup /usr/share/${PN}
	fdo-mime_desktop_database_update
}
