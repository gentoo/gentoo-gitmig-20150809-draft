# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/line6usb/line6usb-0.7.3.ebuild,v 1.6 2009/09/06 21:15:09 robbat2 Exp $

inherit linux-mod eutils multilib

DESCRIPTION="Experimental USB driver for Line6 PODs and the Variax workbench."
HOMEPAGE="http://www.tanzband-scream.at/line6/"
SRC_URI="http://www.tanzband-scream.at/line6/download/${P}.tar.bz2
	doc? ( http://www.tanzband-scream.at/line6/driverdocs.pdf )"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
# needs testing/keywording with 2.6 kernels on ~ppc/ppc64 (should work)
IUSE="doc"

CONFIG_CHECK="USB SOUND"
MODULE_NAMES="line6usb(usb:${S}:${S})"
ERROR_PODXTPRO="${P} requires the podxtpro driver to be removed first."

RDEPEND="virtual/modutils
	dev-lang/perl"

DEPEND="${RDEPEND}
	virtual/alsa
	<virtual/linux-sources-2.6.25
	sys-apps/debianutils"

pkg_setup() {
	ABI="${KERNEL_ABI}"
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
	check_upgrade
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	convert_to_m Makefile

	sed -i \
	    -e "s:/lib/modules/\$(shell uname -r)/build:${KERNEL_DIR}:g" \
	    -e "s:\$(shell uname -r):${KV_FULL}:g" \
	    -e "s:\$(shell pwd):${S}:g" \
	    Makefile || die "sed failed!"
}

src_compile() {
	# linux-mod_src_compile doesn't work here
	set_arch_to_kernel
	cd "${S}"
	emake KERNEL_LOCATION="${KERNEL_DIR}" || die "emake failed."
}

src_install() {
	DESTDIR="${D}" make install-only || die "make install failed"

	# remove some cruft
	rm "${D}"usr/bin/remove_old_podxtpro_driver.sh

	dodoc INSTALL
	if use doc; then
	    insinto /usr/share/doc/${P}
	    doins "${DISTDIR}"/driverdocs.pdf
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog
	elog "This is an experimental driver.  Not responsible for runaway dogs,"
	elog "hair-loss, or sterility.  You have been warned..."
	elog
}

check_upgrade() {
	local old="podxtpro.${KV_OBJ}"
	local new="line6usb.${KV_OBJ}"
	if [[ -e \
	    "/lib/modules/${KV_FULL}/kernel/sound/usb/${old}" ]]; then
		eerror "The previous version of the driver called podxtpro"
		eerror "exists on your system."
		eerror
		eerror "Please completely remove the old driver before trying"
		eerror "to install ${P}."
		eerror
		die "upgrade not possible with existing driver"
	elif [[ -e \
	    "/lib/modules/${KV_FULL}/kernel/sound/usb/${new}" ]]; then
		ewarn
		ewarn "Collisions are expected here, if you removed the ebuild"
		ewarn "(because kernel modules are protected by default).  Use"
		ewarn "FEATURES=-collision-protect emerge ... for this package,"
		ewarn "or remove the old kernel module (${new}) manually first"
		ewarn "from /lib/modules/${KV_FULL}/kernel/sound/usb/"
		ewarn
	fi
}
