# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nforce-audio/nforce-audio-1.0.0256.ebuild,v 1.6 2005/02/04 19:47:45 genstef Exp $

IUSE=""

inherit gcc

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce1/2 SoundStorm audio chipset"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"

LICENSE="NVIDIA GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"
RESTRICT="nostrip"

DEPEND="virtual/linux-sources"

S=${WORKDIR}/nforce

src_compile() {
	check_KV
	cd ${S}/nvaudio
	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/sound
	doins nvaudio/nvaudio.o

	dodoc ${S}/ReleaseNotes.html ${S}/GNULicense.txt ${S}/NVLicense.txt
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] ; then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	echo
	einfo "You need to add \"nvaudio\" to your /etc/modules.autoload to load"
	einfo "this module when the system is started. Alternatively, you can"
	einfo "use the 'hotplug' package ('emerge hotplug' then 'rc-update add"
	einfo "hotplug default') to auto-detect and load \"nvaudio\" on startup."
}
