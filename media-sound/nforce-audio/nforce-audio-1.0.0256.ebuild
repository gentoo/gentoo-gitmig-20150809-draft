# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nforce-audio/nforce-audio-1.0.0256.ebuild,v 1.1 2003/05/07 23:59:27 alron Exp $

inherit gcc

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
S="${WORKDIR}/nforce"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce1/2 SoundStorm audio chipset"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

# The slow needs to be set to $KV to prevent unmerges of
# modules for other kernels.
LICENSE="NVIDIA GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"

DEPEND="virtual/linux-sources >=sys-apps/portage-1.9.10"

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	cd ${S}/nvaudio
	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/sound
	doins nvaudio/nvaudio.o
    
	# Docs
	dodoc ${S}/ReleaseNotes.html ${S}/GNULicense.txt ${S}/NVLicense.txt
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	echo
	einfo "You need to add \"nvaudio\" to your /etc/modules.autoload to load"
	einfo "this module when the system is started. Alternatively, you can"
	einfo "use the 'hotplug' package ('emerge hotplug' then 'rc-update add"
	einfo "hotplug default') to auto-detect and load \"nvaudio\" on startup."
}

