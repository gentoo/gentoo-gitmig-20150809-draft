# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nforce-audio/nforce-audio-1.0.0261.ebuild,v 1.3 2003/09/07 00:06:06 msterret Exp $

inherit gcc

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce1/2 SoundStorm audio chipset"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"

LICENSE="NVIDIA GPL-2"
SLOT="${KV}"
KEYWORDS="-* x86"
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

	dodir /etc/modules.d
	cat > ${D}/etc/modules.d/nvaudio << EOF
# change spdif_status to 1 to enable digital out; this will cause audio
# playback to be clamped to 48KHz which can cause some programs to play
# back audio at the wrong speed.
options nvaudio spdif_status="0"
EOF
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
	echo
	einfo "Edit /etc/modules.d/nvaudio and run \"update-modules\" to configure"
	einfo "the \"nvaudio\" driver to enable digital SPDIF out the next time it"
	einfo "is loaded."
}
