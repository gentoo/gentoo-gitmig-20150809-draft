# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/realtime-lsm/realtime-lsm-0.8.3.ebuild,v 1.1 2004/11/01 04:30:51 fafhrd Exp $

inherit kernel-mod eutils

DESCRIPTION="Enable realtime capabilties via a security module."

HOMEPAGE="http://www.sourceforge.net/projects/realtime-lsm/"
SRC_URI="http://www.joq.us/realtime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"

IUSE=""
DEPEND="virtual/linux-sources
	sys-apps/module-init-tools"
RDEPEND="
	sys-apps/module-init-tools"

src_unpack() {
	if ! kernel-mod_configoption_present MODULES
	then
		eerror ""
		eerror "${PN} requires support for modules in your kernel."
		eerror "In your .config: CONFIG_MODULES=y"
		eerror "Through 'make menuconfig': Loadable module support-> [*] Enable loadable module support"
		eerror ""
		die "Module support not detected."
	fi

	if ! kernel-mod_configoption_present SECURITY
	then
		eerror ""
		eerror "${PN} requires you to compile in the 'different security models option."
		eerror "In your .config: CONFIG_SECURITY=y"
		eerror "Through 'make menuconfig': Security options-> [*] Enable different security models"
		eerror ""
		die "Security support not detected."
	fi

	if ! kernel-mod_configoption_module SECURITY_CAPABILITIES
	then
		eerror ""
		eerror "${PN} requires that 'Default Linux Capabilities' be compiled as a module."
		eerror "In your .config: CONFIG_SECURITY_CAPABILITIES=m"
		eerror "Through 'make menuconfig': Security options-> <M> Default Linux Capabilties"
		eerror ""
		die "Default Linux capabilities (security) not detected."
	fi

	unpack ${A}

	kernel-mod_getversion

	if ! kernel-mod_is_2_6_kernel
	then
		die "A Linux kernel of version 2.6 is required."
	fi

	cd ${S}
	epatch ${FILESDIR}/kmisc.patch-0.8.2_pre20041022
}

src_compile() {
	set_arch_to_kernel

	if [ "${ARCH}" == "ppc" ]; then
		emake KSRC=${ROOT}/usr/src/linux all TOUT=${TMP}/tmp-gas-check || die "compilation stage failed"
	else
		# non ppc arches shouldn't need the TOUT weirdness
		emake KSRC=${ROOT}/usr/src/linux all || die "compilation stage failed"
	fi
}

src_install() {
	set_arch_to_kernel

	emake KSRC=${ROOT}/usr/src/linux KMISC=${D}/lib/modules/${KV}/extra install || die "module installation has failed."

	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}

