# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fritzcapi/fritzcapi-2.6.26.7.ebuild,v 1.2 2004/11/22 06:12:00 mrness Exp $

inherit kernel-mod rpm

S="${WORKDIR}/usr/src/kernel-modules/fritzcapi"

DESCRIPTION="SuSE's 2.6 AVM kernel modules for fcclassic, fcpci, fcpcmcia, fcpnp, fcusb, fcusb2, fxusb_CZ and fxusb"
HOMEPAGE="http://www.avm.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/update/9.1/rpm/i586/km_${P/2.6./2.6-}.i586.rpm"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcmcia usb"

RDEPEND=">=net-dialup/capi4k-utils-20040810"
DEPEND="${RDEPEND}
	virtual/linux-sources"

pkg_setup() {
	if ! kernel-mod_is_2_6_kernel; then
		die "This package works only with 2.6 kernel!"
	fi
	if ! kernel-mod_configoption_present ISDN_CAPI_CAPI20; then
		die "For using the driver you need a kernel with enabled CAPI support."
	fi
	kernel-mod_check_modules_supported
}

src_unpack() {
	rpm_src_unpack ${A} || die "Could not unpack RPM package."
}

src_compile() {
	(
		unset ARCH
		emake KERNEL_SOURCE="${ROOT}/usr/src/linux" modules || die "emake modules failed"
	)
}

src_install() {
	if ! useq pcmcia ; then
		rm fritz.*/src/*pcmcia*.ko
	fi
	if ! useq usb ; then
		rm fritz.*/src/*usb*.ko
	fi

	insinto /lib/modules/${KV_VERSION_FULL}/extra
	doins fritz.*/src/*.ko
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
