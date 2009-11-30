# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-3.9.4b-r1.ebuild,v 1.6 2009/11/30 18:20:27 billie Exp $

EAPI="2"

inherit eutils fdo-mime linux-info python autotools

DESCRIPTION="HP Linux Imaging and Printing System. Includes net-print/hpijs, scanner drivers and service tools."
HOMEPAGE="http://hplipopensource.com/hplip-web/index.html"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

IUSE="cupsddk dbus doc fax gtk minimal parport policykit ppds qt3 qt4 scanner snmp"

# Note : libusb-compat untested (calchan 20090516)

DEPEND="!net-print/hpijs
	!net-print/hpoj
	>=dev-lang/python-2.4.4[threads]
	virtual/ghostscript
	media-libs/jpeg
	>=net-print/foomatic-filters-3.0.20080507[cups]
	!minimal? (
		net-print/cups
		virtual/libusb:0
		cupsddk? ( || ( >=net-print/cups-1.4.0 net-print/cupsddk ) )
		dbus? (
			sys-apps/dbus
			dev-python/dbus-python
			dev-python/pygobject
		)
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
			dev-python/reportlab
			gtk? ( media-gfx/xsane )
			!gtk? ( media-gfx/sane-frontends )
		)
		fax? (
			dev-python/reportlab
		)
		qt3? ( !qt4? (
			dev-python/PyQt
		) )
		qt4? (
			dev-python/PyQt4[X]
		)
		policykit? (
			sys-auth/policykit
			dev-python/pygobject
			dev-python/dbus-python
		)
	)"

CONFIG_CHECK="~PARPORT ~PPDEV"
ERROR_PARPORT="Please make sure parallel port support is enabled in your kernel (PARPORT and PPDEV)."

pkg_setup() {
	! use qt3 && ! use qt4 && ewarn "You need USE=qt3 or USE=qt4 for the hplip GUI."

	use scanner && ! use gtk && ewarn "You need USE=gtk for the scanner GUI."

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

src_prepare() {
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
	sed -i -e "s/55-hpmud.rules/70-hpmud.rules/g" Makefile.* */*.html || die "sed failed"

	# SYSFS deprecated - https://bugs.launchpad.net/hplip/+bug/346390
	sed -i -e "s/SYSFS/ATTRS/g" -e "s/sysfs/attrs/g" data/rules/56-hpmud_support.rules || die "sed failed"

	# plugins check
	mv data/rules/56-hpmud_support.rules data/rules/71-hpmud_support.rules
	sed -i -e "s/56-hpmud_support.rules/71-hpmud_support.rules/g" Makefile.* */*.html || die "sed failed"

	sed -i \
		-e s:/usr/lib/cups/driver:$(cups-config --serverbin)/driver:g \
		installer/core_install.py || die "sed core_install.py"

	# Use system foomatic-rip instead of foomatic-rip-hplip
	local i
	for i in ppd/{hpcups,hpijs}/*.ppd.gz
	do
		rm -f ${i}.temp
		gunzip -c ${i} | sed 's/foomatic-rip-hplip/foomatic-rip/g' | gzip > ${i}.temp || die "*.ppd.gz sed failed"
		mv ${i}.temp ${i}
	done

	# Qt4 is still undocumented by upstream, so use with caution
	local qt_ver
	use qt3 && qt_ver="3"
	use qt4 && qt_ver="4"
	if use qt3 || use qt4 ; then
		sed -i \
			-e "s/%s --force-startup/%s --force-startup --qt${qt_ver}/" \
			-e "s/'--force-startup'/'--force-startup', '--qt${qt_ver}'/" \
			base/device.py || die "sed failed"
		sed -i \
			-e "s/Exec=hp-systray/Exec=hp-systray --qt${qt_ver}/" \
			hplip-systray.desktop.in || die "sed failed"
	fi

	epatch "${FILESDIR}"/${PN}-3.9.4+glibc-2.10.patch

	eautoreconf
}

src_configure() {
	if use qt3 || use qt4 ; then
		local gui_build="--enable-gui-build"
		if use qt4; then
			gui_build="${gui_build} --enable-qt4 --disable-qt3"
		else
			use qt3 && gui_build="${gui_build} --enable-qt3 --disable-qt4"
		fi
	else
		local gui_build="--disable-gui-build"
	fi

	econf \
		--disable-dependency-tracking \
		--disable-cups11-build \
		--with-cupsbackenddir=$(cups-config --serverbin)/backend \
		--with-cupsfilterdir=$(cups-config --serverbin)/filter \
		--disable-foomatic-rip-hplip-install \
		${gui_build} \
		$(use_enable doc doc-build) \
		$(use_enable cupsddk foomatic-drv-install) \
		$(use_enable dbus dbus-build) \
		$(use_enable fax fax-build) \
		$(use_enable minimal hpijs-only-build) \
		$(use_enable parport pp-build) \
		$(use_enable ppds foomatic-ppd-install) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
		$(use_enable policykit policykit)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"/etc/sane.d/dll.conf

	use minimal && rm -r "${D}"/usr/$(get_libdir)

	# bug 106035/259763
	if ! use qt3 && ! use qt4; then
		rm -r "${D}"/usr/share/applications "${D}"/etc/xdg
	fi

	# kde3 autostart hack
	if [[ -d /usr/kde/3.5/share/autostart ]] && use !minimal ; then
		insinto /usr/kde/3.5/share/autostart
		doins hplip-systray.desktop
	fi
}

pkg_preinst() {
	# avoid collisions with cups-1.2 compat symlinks
	if [ -e "${ROOT}"/usr/lib/cups/backend/hp ] && [ -e "${ROOT}"/usr/libexec/cups/backend/hp ]; then
		rm "${ROOT}"/usr/libexec/cups/backend/hp{,fax}
	fi
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
	fdo-mime_desktop_database_update

	elog "You should run hp-setup as root if you are installing hplip for the first time, and may also"
	elog "need to run it if you are upgrading from an earlier version."
	elog
	elog "If your device is connected using USB, users will need to be in the lp group to access it."
	elog
	elog "This release doesn't use an init script anymore, so you should probably do a"
	elog "'rc-update del hplip' if you are updating from an old version."
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
	fdo-mime_desktop_database_update
}
