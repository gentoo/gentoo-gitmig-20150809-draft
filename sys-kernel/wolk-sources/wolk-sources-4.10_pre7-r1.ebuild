# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.10_pre7-r1.ebuild,v 1.3 2004/01/06 00:28:57 plasmaroo Exp $

IUSE="build wolk-bootsplash wolk-supermount ipv6"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.20
EXTRAVERSION="-${PN/-*/}4.10s-pre7"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}
DESCRIPTION="Working Overloaded Linux Kernel (Server-Edition)"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips"
SRC_PATH="mirror://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"

SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.0s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.0s-to-4.1s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.1s-to-4.2s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.2s-to-4.3s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.3s-to-4.4s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.4s-to-4.5s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.5s-to-4.6s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.6s-to-4.7s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.7s-to-4.8s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.8s-to-4.9s.patch.bz2
	http://wolk.sourceforge.net/tmp/4.10s-pre7-update.patch.bz2
	wolk-bootsplash? ( http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.7-2.4.20-0.patch
			 http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.7-2.4.20-1-aty128.patch
			 http://wolk.sourceforge.net/Workstation-Edition/1007_bootsplash-v3.0.8-2.4.20-update.patch)
	wolk-supermount? ( http://wolk.sourceforge.net/Workstation-Edition/1008_supermount-1.2.9-2.4.20-OLDIDE.patch)
	ipv6? ( http://wolk.sourceforge.net/Workstation-Edition/1009_mipv6-0.9.5.1-v2.4.20-wolk4.0s.patch )"

SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
local PATCHEFILES="-wolk4.0s -wolk4.0s-to-4.1s -wolk4.1s-to-4.2s -wolk4.2s-to-4.3s -wolk4.3s-to-4.4s -wolk4.4s-to-4.5s -wolk4.5s-to-4.6s -wolk4.6s-to-4.7s -wolk4.7s-to-4.8s -wolk4.8s-to-4.9s"

	unpack linux-${OKV}.tar.bz2 || die
		mv linux-${OKV} linux-${KV} || die
		cd ${WORKDIR}/linux-${KV} || die
		for PATCHES in ${PATCHEFILES}
		do
			epatch ${DISTDIR}/linux-${OKV}${PATCHES}.patch.bz2 || die
		done

	epatch ${DISTDIR}/4.10s-pre7-update.patch.bz2 || die

		if [ "`use wolk-supermount`" ]; then
			einfo "Applying Supermount patch"
			epatch ${DISTDIR}/1008_supermount-1.2.9-2.4.20-OLDIDE.patch  || die
		fi
		if [ "`use ipv6`" ]; then
			einfo "Applying MIPv6 patch"
			epatch ${DISTDIR}/1009_mipv6-0.9.5.1-v2.4.20-wolk4.0s.patch  || die
		fi
		if [ "`use wolk-bootsplash`" ]; then
			einfo "Applying Bootsplash patchset"
			epatch ${DISTDIR}/1007_bootsplash-v3.0.7-2.4.20-0.patch  || die
			epatch ${DISTDIR}/1007_bootsplash-v3.0.7-2.4.20-1-aty128.patch  || die
			epatch ${DISTDIR}/1007_bootsplash-v3.0.8-2.4.20-update.patch || die
		fi

	# unnecessary according to:
	# http://article.gmane.org/gmane.linux.wolk.devel/275
	#epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	kernel_universal_unpack
}

pkg_postinst() {
	einfo
	einfo "Since wolk-sources-4.6s the 3com 3c59x v0.99Za drivers are excluded."
	einfo "For many people they may work, but too many people expecting problems"
	einfo "with this drivers. They will be reintroduced when they are fixed."
	einfo "You have to fall back to an earlier release of the wolk kernel when you want"
	einfo "to use one of this drivers."
	einfo
	einfo "This new ebuild has support for the workstation patches."
	einfo "With the wolk-bootsplash, wolk-supermount, and ipv6"
	einfo "use flags you can take advantage of the, "
	einfo "Bootsplash, Supermount, MIPv6 patches."
	ewarn "Patches not guaranteed; YMMV..."
	einfo
}

