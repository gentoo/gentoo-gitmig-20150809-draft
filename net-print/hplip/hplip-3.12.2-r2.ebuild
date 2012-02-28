# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-3.12.2-r2.ebuild,v 1.1 2012/02/28 17:56:09 billie Exp $

EAPI=4

PYTHON_DEPEND="!minimal? 2"
PYTHON_USE_WITH="threads xml"
PYTHON_USE_WITH_OPT="!minimal"

inherit fdo-mime linux-info python autotools

DESCRIPTION="HP Linux Imaging and Printing. Includes printer, scanner, fax drivers and service tools."
HOMEPAGE="http://hplipopensource.com/hplip-web/index.html"
SRC_URI="mirror://sourceforge/hplip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

# zeroconf does not work properly with >=cups-1.4.
# Thus support for it is also disabled in hplip.
IUSE="doc fax +hpcups hpijs kde libnotify minimal parport policykit qt4 scanner snmp static-ppds -acl X"

REQUIRED_USE="|| ( hpijs hpcups )"

COMMON_DEPEND="
	virtual/jpeg
	hpijs? ( >=net-print/foomatic-filters-3.0.20080507[cups] )
	acl? ( || ( >=sys-fs/udev-171[acl] >=sys-fs/udev-145[extras] ) )
	!minimal? (
		>=net-print/cups-1.4.0
		virtual/libusb:0
		scanner? ( >=media-gfx/sane-backends-1.0.19-r1 )
		fax? ( sys-apps/dbus )
		snmp? (
			net-analyzer/net-snmp
			dev-libs/openssl
		)
	)"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	>=app-text/ghostscript-gpl-8.71-r3
	policykit? (
		sys-auth/polkit
	)
	!minimal? (
		dev-python/pygobject:2
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
		)
	)"

CONFIG_CHECK="~PARPORT ~PPDEV"
ERROR_PARPORT="Please make sure kernel parallel port support is enabled (PARPORT and PPDEV)."

pkg_setup() {
	if ! use minimal; then
		python_set_active_version 2
		python_pkg_setup
	fi

	! use qt4 && ewarn "You need USE=qt4 for the hplip GUI."

	use scanner && ! use X && ewarn "You need USE=X for the scanner GUI."

	if use minimal ; then
		ewarn "Installing driver portions only, make sure you know what you are doing."
		ewarn "Depending on the USE flags set for hpcups or hpijs the appropiate driver"
		ewarn "is installed. If both USE flags are set hpijs overrides hpcups."
	else
		use parport && linux-info_pkg_setup
	fi
}

src_prepare() {
	use !minimal && python_convert_shebangs -q -r 2 .

	# Fix for Gentoo bug #345725
	sed -i -e "s|/etc/udev/rules.d|/lib/udev/rules.d|" \
		$(find ./ -type f -exec grep -l '/etc/udev/rules.d' '{}' '+') \
		|| die

	# Do not install desktop files if there is no gui
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/452113
	epatch "${FILESDIR}"/${PN}-3.11.1-desktop.patch

	# Browser detection through xdg-open
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/482674
	epatch "${FILESDIR}"/${PN}-3.9.10-browser.patch

	# Use cups-config when checking for cupsddk
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/483136
	epatch "${FILESDIR}"/${PN}-3.9.12-cupsddk.patch

	# Htmldocs are not installed under docdir/html so enable htmldir configure
	# switch
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/483217
	epatch "${FILESDIR}"/${PN}-3.11.1-htmldir.patch

	# Let 56-hpmud_support.rules call hp-mkuri to make it work with newer udev
	# Upstream bug: None
	epatch "${FILESDIR}"/${PN}-3.11.12-udev-rules.patch

	# CVE-2010-4267 SNMP Response Processing Buffer Overflow Vulnerability
	# http://secunia.com/advisories/42956/
	# https://bugzilla.redhat.com/show_bug.cgi?id=662740
	epatch "${FILESDIR}"/${PN}-3.10.9-cve-2010-4267.patch

	# Fix black stripes on pcl5c printouts
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/561264
	epatch "${FILESDIR}"/${PN}-3.11.12-black-stripes-pcl5c.patch

	# Fix parallel port cpu usage
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/750796
	epatch "${FILESDIR}"/${PN}-3.11.12-fast-pp.patch

	# Fix minmal/hpijs_only/hpcups_only install
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/932918
	epatch "${FILESDIR}"/${P}-minimal.patch

	# Fix Option parsing in sane/scan.py
	# Upstream bug: https://bugs.launchpad.net/hplip/+bug/927708
	epatch "${FILESDIR}"/${P}-sane.patch

	# Force recognition of Gentoo distro by hp-check
	sed -i \
		-e "s:file('/etc/issue', 'r').read():'Gentoo':" \
		installer/core_install.py || die

	# Use system foomatic-rip for hpijs driver instead of foomatic-rip-hplip
	# The hpcups driver does not use foomatic-rip
	local i
	for i in ppd/hpijs/*.ppd.gz ; do
		rm -f ${i}.temp
		gunzip -c ${i} | sed 's/foomatic-rip-hplip/foomatic-rip/g' | \
			gzip > ${i}.temp || die
		mv ${i}.temp ${i}
	done

	eautoreconf
}

src_configure() {
	local myconf drv_build minimal_build

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
		drv_build="--disable-hpcups-install"
		drv_build="${drv_build} --disable-cups-drv-install"
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
		--disable-cups11-build \
		--disable-lite-build \
		--disable-foomatic-rip-hplip-install \
		--disable-shadow-build \
		--disable-qt3 \
		--with-cupsbackenddir=$(cups-config --serverbin)/backend \
		--with-cupsfilterdir=$(cups-config --serverbin)/filter \
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		${myconf} \
		${drv_build} \
		${minimal_build} \
		$(use_enable doc doc-build) \
		$(use_enable fax fax-build) \
		$(use_enable parport pp-build) \
		$(use_enable scanner scan-build) \
		$(use_enable snmp network-build) \
		$(use_enable acl udev-acl-rules) \
		$(use_enable qt4 gui-build) \
		$(use_enable qt4) \
		$(use_enable policykit)
}

src_install() {
	default

	# Installed by sane-backends
	# Gentoo Bug: #201023
	rm -f "${D}"/etc/sane.d/dll.conf || die

	rm -f "${D}"/usr/share/doc/${PF}/{copyright,README_LIBJPG,COPYING} || die
	rmdir --ignore-fail-on-non-empty "${D}"/usr/share/doc/${PF}/ || die

	# Remove hal fdi files
	rm -rf "${D}"/usr/share/hal || die

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die
}

pkg_postinst() {
	use !minimal && python_mod_optimize /usr/share/${PN}
	fdo-mime_desktop_database_update

	elog "For more information on setting up your printer please take"
	elog "a look at the hplip section of the gentoo printing guide:"
	elog "http://www.gentoo.org/doc/en/printing-howto.xml"
}

pkg_postrm() {
	use !minimal && python_mod_cleanup /usr/share/${PN}
	fdo-mime_desktop_database_update
}
