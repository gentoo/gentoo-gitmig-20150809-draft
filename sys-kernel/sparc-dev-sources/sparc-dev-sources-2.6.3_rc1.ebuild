# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-dev-sources/sparc-dev-sources-2.6.3_rc1.ebuild,v 1.1 2004/02/09 01:01:11 wesolows Exp $

IUSE="ultra1"

ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the SPARC32/64 development kernel"
PATCHBALL="patches-${KV}.tar.bz2"
SRC_URI="${KERNEL_URI}
	mirror://gentoo/${PATCHBALL}"

KEYWORDS="~x86 ~sparc"

DEPEND="${DEPEND} !<sys-apps/pciutils-2.1.11-r1"
[ `uname -m` = "sparc64" ] && DEPEND="${DEPEND} >=sys-devel/gcc-sparc64-3.2.3"

UNIPATCH_LIST="${DISTDIR}/${PATCHBALL}"

[ ! `use ultra1` ] && UNIPATCH_EXCLUDE="99_U1-hme-lockup"

K_EXTRAEWARN="IMPORTANT:
ptyfs support has now been dropped from devfs and as a
result you are now required to compile this support into
the kernel. You can do so by enabling the following options:
	Device Drivers -> Character devices  -> Unix98 PTY Support,
	File systems   -> Pseudo filesystems -> /dev/pts filesystem."

if [ ! -r "/proc/openprom/name" -o "`cat /proc/openprom/name 2>/dev/null`" = "'SUNW,Ultra-1'" ]; then
	K_EXTRAEINFO="For users with an Enterprise model Ultra 1 using the HME
	network interface, please emerge the kernel using the following command:
	USE=ultra1 emerge sparc-sources-dev"
fi
