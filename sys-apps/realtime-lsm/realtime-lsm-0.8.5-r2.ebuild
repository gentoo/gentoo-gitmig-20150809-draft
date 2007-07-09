# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/realtime-lsm/realtime-lsm-0.8.5-r2.ebuild,v 1.4 2007/07/09 14:43:40 flameeyes Exp $

inherit linux-mod eutils

DESCRIPTION="Enable realtime capabilties via a security module."

HOMEPAGE="http://www.sourceforge.net/projects/realtime-lsm/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

MODULE_NAMES="realtime(extra:)"
BUILD_TARGETS="all"
MODULESD_REALTIME_DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${ROOT}${KV_DIR} KERNEL_DIR=${ROOT}${KV_DIR} O=${KV_OUT_DIR} TOUT=${TMP}/tmp-gas-check"
}

src_unpack() {
	if ! kernel_is 2 6; then
		die "A Linux kernel of version 2.6 is required."
	fi

	if ! linux_chkconfig_present SECURITY; then
		eerror ""
		eerror "${PN} requires you to compile in the 'different security models option."
		eerror "In your .config: CONFIG_SECURITY=y"
		eerror "                 CONFIG_SECURITY_CAPABILITIES=m"
		eerror "Through 'make menuconfig': Security options-> [*] Enable different security models"
		eerror "                           Security options-> <M> Default Linux Capabilties"
		eerror ""
		die "Security support not detected."
	fi

	if ! linux_chkconfig_module SECURITY_CAPABILITIES; then
		eerror ""
		eerror "${PN} requires that 'Default Linux Capabilities' be compiled as a module."
		eerror "In your .config: CONFIG_SECURITY_CAPABILITIES=m"
		eerror "Through 'make menuconfig': Security options-> <M> Default Linux Capabilties"
		eerror ""
		die "Default Linux capabilities (security) not detected."
	fi

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/kmisc.patch-0.8.2_pre20041022"
	convert_to_m Makefile
}

src_install() {
	linux-mod_src_install

	rm "${D}/etc/modules.d/realtime" || die "unable to remove upstream configuration file"

	insinto /etc/modules.d
	newins "${FILESDIR}/modulesd-realtime" "realtime"
}

pkg_preinst() {
	enewgroup realtime

	sed -i -e "s:@REALTIMEGROUPID@:$(egetent group realtime | cut -d : -f 3):" \
		"${D}/etc/modules.d/realtime"
}

pkg_postinst() {
	elog "The default configuration for realtime-lsm is now to allow"
	elog "realtime usage for all the users in the 'realtime' group."
	elog "This is accomplished in the default /etc/modules.d/realtime"
	elog "configuration file, by passing the gid parameter to the module."
	elog ""
	elog "If you want (some of) your users to run code with realtime"
	elog "priority, just add the user to that group."
	elog "Please note that changing this default behaviour might interfere"
	elog "with the default configuration of other software like PulseAudio."
	elog ""
	elog "For more information please consult the Realtime for Multimedia"
	elog "guide at http://www.gentoo.org/proj/en/desktop/sound/realtime.xml"
}
