# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nforce-net/nforce-net-1.0.0256.ebuild,v 1.1 2003/05/04 12:37:15 aliz Exp $

inherit gcc

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
S="${WORKDIR}/nforce"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce network chip"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

# The slow needs to be set to $KV to prevent unmerges of
# modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="~x86 -ppc -sparc -alpha"

DEPEND="virtual/linux-sources >=sys-apps/portage-1.9.10"

src_unpack() {
	unpack ${A}
	if [ `gcc-major-version` -eq 2 ] ; then
		einfo "Applying gcc2 compatability patch"
	        cp nforce/nvnet/Makefile{,.old}
        	sed -e "s/-falign-functions/-malign-functions/" nforce/nvnet/Makefile.old > nforce/nvnet/Makefile
	fi
}

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	#IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	#updated but the running kernel is still compiled with an older gcc.  This is
	#needed for chrooted building, where the sanity check detects the gcc of the
	#kernel outside the chroot rather than within.
	cd ${S}/nvnet
	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/net
	doins nvnet/nvnet.o
    
	# Docs
	dodoc ${S}/README
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	echo
	einfo "You need to add \"nvnet\" to your /etc/modules.autoload to load"
	einfo "this module when the system is started."
}

