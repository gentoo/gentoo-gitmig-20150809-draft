# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.2880.ebuild,v 1.2 2002/04/25 06:56:22 drobbins Exp $

NV_V=${PV/1.0./1.0-}
NV_PACKAGE=NVIDIA_kernel-${NV_V}
S="${WORKDIR}/${NV_PACKAGE}"
DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
SRC_URI="ftp://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz
	http://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/linux-sources"

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"


nv_get_kernel_version () {
	# Determine the version of the kernel sources
	local NV_KV="`readlink /usr/src/linux`"
	if [ $? -ne 0 ]
	then
		die "/usr/src/linux does not exist"
	fi
	NV_KV="${NV_KV/linux-/}"
	echo -n "${NV_KV}"
}

src_compile() {
	make KERNDIR="/usr/src/linux-`nv_get_kernel_version`" \
		clean NVdriver || die
}

src_install () {
	# The driver goes into the standard modules location
	insinto "/lib/modules/`nv_get_kernel_version`/kernel/video"
	doins NVdriver
    
	# Add the aliases
	insinto /etc/modules.d
	doins "${FILESDIR}"/nvidia

	# Docs
	dodoc ${S}/README

	# The device creation script
	into /
	newsbin ${S}/makedevices.sh NVmakedevices.sh
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Get any stale module unloaded
		[ -x /sbin/rmmod ]              && /sbin/rmmod NVdriver
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		# Load the module again
		[ -x /sbin/modprobe ]           && /sbin/modprobe NVdriver
		if [ ! -e /dev/.devfsd ] && [ -x /sbin/NVmakedevices.sh ]
		then
			/sbin/NVmakedevices.sh >/dev/null 2>&1
		fi
	fi

	einfo
	einfo "If you are not using devfs, you might want to create nvidia"
	einfo "device nodes by running /sbin/NVmakedevices.sh"
	einfo
	einfo "To load the module automatically at boot up, add"
	einfo "\"NVdriver\" to your /etc/modules.autoload:"
	einfo
}

