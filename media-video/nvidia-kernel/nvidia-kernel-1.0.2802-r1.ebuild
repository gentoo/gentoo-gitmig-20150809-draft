# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

NV_V=1.0-2802

# Make sure Portage does _NOT_ strip symbols.  Need both lines for 
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"

DEPEND="virtual/linux-sources"

NV_PACKAGE=NVIDIA_kernel-${NV_V}
SRC_URI="http://205.158.109.140/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"
S="${WORKDIR}/${NV_PACKAGE}"

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
    dodoc README

    # The device creation script
    exeinto /opt/nvidia/bin
    doexe "${FILESDIR}"/make_nvidia_devices.sh
}

pkg_postinst() {
    if [ "${ROOT}" = "/" ]
    then
        [ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
        [ -x /sbin/depmod ]             && /sbin/depmod -a
    fi

    einfo
    einfo "If you are not using devfs, you might want to create nvidia"
    einfo "device nodes by running /opt/nvidia/bin/make_nvidia_devices.sh"
    einfo
    einfo "To load the module automatically at boot up, add"
    einfo "\"NVdriver\" to your /etc/modules.autoload:"
    einfo
}
