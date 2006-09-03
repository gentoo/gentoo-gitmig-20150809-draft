# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors/lm_sensors-2.10.0.ebuild,v 1.7 2006/09/03 09:07:55 hansmi Exp $

inherit eutils flag-o-matic linux-info toolchain-funcs multilib

DESCRIPTION="Hardware Monitoring user-space utilities"

HOMEPAGE="http://www.lm-sensors.org/"
SRC_URI="http://dl.lm-sensors.org/lm-sensors/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="sensord"

COMMON="sys-fs/sysfsutils
		sensord? ( net-analyzer/rrdtool )"
DEPEND="${COMMON}
		sys-apps/sed
		ppc? ( >=virtual/linux-sources-2.5 )
		amd64? ( >=virtual/linux-sources-2.5 )
		x86? ( || ( >=virtual/linux-sources-2.5 sys-apps/lm_sensors-modules ) )"
RDEPEND="${COMMON}
		dev-lang/perl"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is 2 4; then
		if use ppc || use amd64; then
			eerror
			eerror "${P} does not support kernel 2.4.x under PPC and AMD64."
			eerror
			die "${P} does not support kernel 2.4.x under PPC and AMD64."
		elif ! has_version =sys-apps/lm_sensors-modules-${PV}; then
			eerror
			eerror "${P} needs sys-apps/lm_sensors-modules-${PV} to be installed"
			eerror "for kernel 2.4.x"
			eerror
			die "sys-apps/lm_sensors-modules-${PV} not installed"
		fi
	else
		if kernel_is lt 2 6 14 && ! (linux_chkconfig_present I2C_SENSOR); then
			eerror
			eerror "${P} requires CONFIG_I2C_SENSOR to be enabled for non-2.4.x kernels."
			eerror
			die "CONFIG_I2C_SENSOR not detected"
		elif kernel_is gt 2 6 13 && ! (linux_chkconfig_present HWMON); then
			eerror
			eerror "${P} requires CONFIG_HWMON to be enabled for 2.6.14+ kernels."
			eerror
			die "CONFIG_HWMON not detected"
		fi
		if ! (linux_chkconfig_present I2C_CHARDEV); then
			ewarn
			ewarn "sensors-detect requires CONFIG_I2C_CHARDEV to be enabled for non-2.4.x kernels."
			ewarn
		fi
		if ! (linux_chkconfig_present I2C); then
			eerror
			eerror "${P} requires CONFIG_I2C to be enabled for non-2.4.x kernels."
			eerror
			die "CONFIG_I2C not detected"
		fi
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-sensors-detect-gentoo.patch

	if use sensord; then
		sed -i -e 's:^# \(PROG_EXTRA\):\1:' "${S}"/Makefile
	fi
}

src_compile()  {
	einfo
	einfo "You may safely ignore any errors from compilation"
	einfo "that contain \"No such file or directory\" references."
	einfo

	filter-flags -fstack-protector

	emake CC=$(tc-getCC) LINUX=${KV_DIR} I2C_HEADERS=${KV_DIR}/include user \
		|| die "emake user failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man LIBDIR=/usr/$(get_libdir) \
		KERNELINCLUDEFILES="" user_install || die "emake user_install failed"

	newinitd "${FILESDIR}"/${P}-lm_sensors-init.d lm_sensors
	newinitd "${FILESDIR}"/${P}-fancontrol-init.d fancontrol

	if use sensord; then
		newconfd "${FILESDIR}"/${P}-sensord-conf.d sensord
		newinitd "${FILESDIR}"/${P}-sensord-init.d sensord
	fi

	dodoc BACKGROUND BUGS CHANGES CONTRIBUTORS INSTALL QUICKSTART \
		README* TODO

	dodoc doc/cvs doc/donations doc/fancontrol.txt doc/fan-divisors doc/FAQ \
		doc/progs doc/temperature-sensors doc/vid

	dohtml doc/lm_sensors-FAQ.html doc/useful_addresses.html

	docinto busses
	dodoc doc/busses/*

	docinto chips
	dodoc doc/chips/*

	docinto developers
	dodoc doc/developers/applications doc/developers/design \
		doc/developers/new_drivers doc/developers/proc \
		doc/developers/sysctl doc/developers/sysfs-interface
}

pkg_postinst() {
	einfo
	einfo "Next you need to run:"
	einfo "  /usr/sbin/sensors-detect"
	einfo "to detect the I2C hardware of your system and create the file:"
	einfo "  /etc/conf.d/lm_sensors"
	einfo
	einfo "You will also need to run the above command if you're upgrading from"
	einfo "<=${PN}-2.9.0, as the needed entries in /etc/conf.d/lm_sensors has"
	einfo "changed."
	einfo
	einfo "Be warned, the probing of hardware in your system performed by"
	einfo "sensors-detect could freeze your system. Also make sure you read"
	einfo "the documentation before running lm_sensors on IBM ThinkPads."
	einfo
	einfo "Please see the lm_sensors documentation and website for more information."
	einfo
}
