# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="build wolk-alsa wolk-bootsplash wolk-supermount ipv6"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.20
KV=${OKV}-wolk4.10s-pre7
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
	ipv6? ( http://wolk.sourceforge.net/Workstation-Edition/1009_mipv6-0.9.5.1-v2.4.20-wolk4.0s.patch )
	wolk-alsa? ( http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-00-core.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-01-addition.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-02-config.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-03-wrappers.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-04-compilefix.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-05-ioctl32.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-06-isapnp.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-07-pnp.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-08-ppc.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-09-nosymbols.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-10-procdevs.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-11-pdplus.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-12-serialmidi.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-13-mixart.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-14-msnd.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-15-options-fix.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-16-ac97-fix.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-17-supress-debug.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-18-wolk-stuff.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-19-compilefixes.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-20-more-compilefixes.patch
		http://wolk.sourceforge.net/Workstation-Edition/1010_alsa-0.9.6-21-yet-more-compilefixes.patch )"

SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
	local PATCHEFILES="-wolk4.0s -wolk4.0s-to-4.1s -wolk4.1s-to-4.2s -wolk4.2s-to-4.3s -wolk4.3s-to-4.4s -wolk4.4s-to-4.5s -wolk4.5s-to-4.6s -wolk4.6s-to-4.7s -wolk4.7s-to-4.8s -wolk4.8s-to-4.9s"
	local ALSAFILES="-00-core.patch -01-addition.patch -02-config.patch -03-wrappers.patch -04-compilefix.patch -05-ioctl32.patch -06-isapnp.patch -07-pnp.patch -08-ppc.patch -09-nosymbols.patch -10-procdevs.patch -11-pdplus.patch -12-serialmidi.patch -13-mixart.patch -14-msnd.patch -15-options-fix.patch -16-ac97-fix.patch -17-supress-debug.patch -18-wolk-stuff.patch -19-compilefixes.patch -20-more-compilefixes.patch -21-yet-more-compilefixes.patch"

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
	if [ "`use wolk-alsa`" ]; then
		einfo "Applying Alsa patchset"

	for FILES in ${ALSAFILES}
		do
			patch -p1 < ${DISTDIR}/1010_alsa-0.9.6${FILES} || die
		done
	fi
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
	einfo "The new useflag is wolk-alsa and it enables of"
	einfo "course internal alsa-support for wolk"
	einfo
}
