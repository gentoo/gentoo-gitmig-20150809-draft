# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/alpha-sources/alpha-sources-2.4.21-r13.ebuild,v 1.1 2004/11/06 21:36:45 plasmaroo Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE="crypt usagi"
ETYPE="sources"
inherit kernel eutils
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo Linux Alpha kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV/13/3}.tar.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.patch"
SLOT="${KV}"
KEYWORDS="alpha -sparc -x86 -ppc -hppa -mips"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/${KV/13/1}

	# This is the crypt USE flag, keeps {USAGI/superfreeswan/patch-int/loop-jari}
	if ! use crypt; then
	    einfo "No Cryptographic support, dropping patches..."
	    for file in 6* 8* ;do
		einfo "Dropping ${file}..."
		rm -f ${file}
	    done
	else
	    einfo "Cryptographic patches will be applied"
	fi

	# This is the usagi USE flag, keeps USAGI, drops
	# {superfreeswan/patch-int/loop-jari}
	# Using USAGI will also cause you to drop all iptables ipv6
	# patches.
	if ! use usagi; then
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

	cd ${S}
	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch the do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0075.patch || die "Failed to add the CAN-2004-0075 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0109.patch || die "Failed to patch CAN-2004-0109 vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0133.patch || die "Failed to add the CAN-2004-0133 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0181.patch || die "Failed to add the CAN-2004-0181 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0427.patch || die "Failed to add the CAN-2004-0427 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0535.patch || die "Failed to add the CAN-2004-0535 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/${P}-CAN-2004-0814.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${PN}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	epatch ${FILESDIR}/${PN}.munmap.patch || die "Failed to apply munmap patch!"
	epatch ${FILESDIR}/${PN}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${PN}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR fix!"

	# Fix multi-line literal in include/asm-alpha/xor.h -- see bug 38354
	# If this script "dies" then that means it's no longer applicable.
	mv include/asm-alpha/xor.h{,.multiline}
	awk 'BEGIN     { addnl=0; exitstatus=1 }
		 /^asm\("/ { addnl=1 }
		 /^"\)/    { addnl=0 }
		 addnl && !/\\n\\$/ { sub("$", " \\n\\", $0); exitstatus=0 }
				   { print }
		 END       { exit exitstatus }' \
		 <include/asm-alpha/xor.h.multiline >include/asm-alpha/xor.h
	assert "awk script failed, probably doesn't apply to ${KV}"
	rm -f include/asm-alpha/xor.h.multiline
}
