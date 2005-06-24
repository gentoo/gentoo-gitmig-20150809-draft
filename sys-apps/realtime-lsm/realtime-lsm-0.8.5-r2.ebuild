# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/realtime-lsm/realtime-lsm-0.8.5-r2.ebuild,v 1.1 2005/06/24 04:26:41 fafhrd Exp $

inherit linux-mod eutils

DESCRIPTION="Enable realtime capabilties via a security module."

HOMEPAGE="http://www.joq.us/"
#HOMEPAGE="http://www.sourceforge.net/projects/realtime-lsm/"
SRC_URI="http://www.joq.us/realtime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"

IUSE="allcaps"
DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}"

MODULE_NAMES="realtime(extra:)"
BUILD_PARAMS="KSRC=${ROOT}${KV_DIR} TOUT=${TMP}/tmp-gas-check"
BUILD_TARGETS="all"
MODULESD_REALTIME_DOCS="AUTHORS ChangeLog README"

src_unpack() {
	if ! linux_chkconfig_present SECURITY
	then
		eerror ""
		eerror "${PN} requires you to compile in the 'different security models option."
		eerror "In your .config: CONFIG_SECURITY=y"
		eerror "                 CONFIG_SECURITY_CAPABILITIES=m"
		eerror "Through 'make menuconfig': Security options-> [*] Enable different security models"
		eerror "                           Security options-> <M> Default Linux Capabilties"
		eerror ""
		die "Security support not detected."
	fi

	if ! linux_chkconfig_module SECURITY_CAPABILITIES
	then
		eerror ""
		eerror "${PN} requires that 'Default Linux Capabilities' be compiled as a module."
		eerror "In your .config: CONFIG_SECURITY_CAPABILITIES=m"
		eerror "Through 'make menuconfig': Security options-> <M> Default Linux Capabilties"
		eerror ""
		die "Default Linux capabilities (security) not detected."
	fi

	if ! kernel_is 2 6
	then
		die "A Linux kernel of version 2.6 is required."
	fi

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/kmisc.patch-0.8.2_pre20041022
	if use allcaps; then
		epatch ${FILESDIR}/realtime-lsm-${PV}-allcaps.patch
	fi
	convert_to_m Makefile
}

