# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/alpha-sources/alpha-sources-2.4.21-r1.ebuild,v 1.5 2003/09/09 08:51:13 msterret Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE="build crypt usagi"
ETYPE="sources"
inherit kernel

DESCRIPTION="Full sources for the Gentoo Linux Alpha kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"
SLOT="${KV}"
KEYWORDS="alpha -sparc -x86 -ppc -hppa -mips -arm"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/${KV}

	# This is the crypt USE flag, keeps {USAGI/superfreeswan/patch-int/loop-jari}
	if [ -z "`use crypt`" ]; then
	    einfo "No Cryptographic support, dropping patches..."
	    for file in 6* 8* ;do
		einfo "Dropping ${file}..."
		rm -f ${file}
	    done
	else
	    einfo "Cryptographic patches will be applied"
	fi

	# This is the usagi USE flag, keeps USAGI, drops {superfreeswan/patch-int/loop-jari}
	# Using USAGI will also cause you to drop all iptables ipv6 patches
	if [ -z "`use usagi`" ]; then
		einfo "Keeping {superfreeswan/patch-int/loop-jari} patches, dropping USAGI"
		for file in 6* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Keeping USAGI patch, dropping {superfreeswan/patch-int/loop-jari}"
		for file in *.ipv6 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi

	kernel_src_unpack
}
