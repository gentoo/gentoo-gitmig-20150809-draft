# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/grsec-sources/grsec-sources-2.4.26.2.0-r7.ebuild,v 1.1 2004/08/04 18:41:10 solar Exp $

# We control what versions of what we download based on the KEYWORDS we
# are using for the various arches. Thus if we want grsec1 stable we run
# the with "arch" ACCEPT_KEYWORDS or ~arch and we will get the
# grsec-2.0-preX which has alot more features.

# the only thing that should ever differ in one of these 1.9.x ebuilds
# and 2.x of the same kernel version is the KEYWORDS and header.
# shame cvs symlinks don't exist

ETYPE="sources"
IUSE=""

inherit eutils kernel

[ "$OKV" == "" ] && OKV="2.4.26"

PATCH_BASE="${PV/${OKV}./}"
PATCH_BASE="${PATCH_BASE/_/-}"
EXTRAVERSION="-grsec-${PATCH_BASE}"
KV="${OKV}${EXTRAVERSION}"

PATCH_SRC_BASE="grsecurity-${PATCH_BASE}-${OKV}.patch.bz2"

# hppa takes a special patch and usually has play catch up between
# versions of this package.
HPPA_SRC_URI=""
if [ "${ARCH}" == "hppa" ]; then
	PARISC_KERNEL_VERSION="pa1"
	KV="${OKV}-${PARISC_KERNEL_VERSION}${EXTRAVERSION}"
	HPPA_PATCH_SRC_BASE="parisc-linux-${OKV}-${PARISC_KERNEL_VERSION}${EXTRAVERSION}.gz"
	HPPA_SRC_URI="mirror://gentoo/${HPPA_PATCH_SRC_BASE} http://dev.gentoo.org/~pappy/gentoo-x86/sys-kernel/grsec-sources/${HPPA_PATCH_SRC_BASE}"
	PATCH_SRC_BASE="${HPPA_PATCH_SRC_BASE}"
fi

DESCRIPTION="Vanilla sources of the linux kernel with the grsecurity ${PATCH_BASE} patch"

CAN_PATCHES="http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.26-CAN-2004-0415.patch"

SRC_URI="mirror://gentoo/grsecurity-${PATCH_BASE}-${OKV}.patch.bz2 \
	http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 ${CAN_PATCHES}"


HOMEPAGE="http://www.kernel.org/ http://www.grsecurity.net"

KEYWORDS="x86 sparc ppc alpha amd64 -hppa"

SLOT="${KV}"
S="${WORKDIR}/linux-${KV}"

src_unpack() {
	unpack linux-"${OKV}".tar.bz2 || die "unable to unpack the kernel"
	mv linux-"${OKV}" linux-"${KV}" || die "unable to move the kernel"
	cd linux-"${KV}" || die "unable to cd into the kernel source tree"

	patch_grsec_kernel

	mkdir docs
	touch docs/patches.txt
	kernel_universal_unpack

}

patch_grsec_kernel() {
	# users are often confused by what settings should be set.
	# so we provide an  example of what a P4 desktop would look like.
	cp ${FILESDIR}/2.4.24-x86.config gentoo-grsec-custom-example-2.4.24-x86.config


	[ -f "${DISTDIR}/${PATCH_SRC_BASE}" ] || die "File ${PATCH_SRC_BASE} does not exist?"
	ebegin "Patching the kernel with ${PATCH_SRC_BASE}"
	case "${ARCH}" in
		hppa)	zcat ${DISTDIR}/${PATCH_SRC_BASE} | patch -g0 -p1 --quiet ;;
		*)	bzcat  ${DISTDIR}/${PATCH_SRC_BASE} | patch -g0 -p1 --quiet ;;
	esac
	[ $? == 0 ] || die "failed patching with ${PATCH_SRC_BASE}"
	eend 0

	# fix format string problem in panic()
	epatch ${FILESDIR}/2.4.26-CAN-2004-0394.patch
	# Fix local DoS bug #53804
	epatch ${FILESDIR}/2.4.26-signal-race.patch

	# i2c integer overflow vulnerability during the allocation of memory
	#epatch ${FILESDIR}/2.4.26-i2cproc_bus_read.patch

	# patch to force randomization to always at least PAGE_SIZE big.
	epatch ${FILESDIR}/2.4.26-pax-binfmt_elf-page-size.patch

	epatch ${FILESDIR}/gentoo-sources-2.4.CAN-2004-0495.patch
	epatch ${FILESDIR}/gentoo-sources-2.4.CAN-2004-0535.patch

	# Bug 56479 - fchown-attr
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0497.patch

	# file offset pointer handling vulnerability - Bug 59378
	epatch ${DISTDIR}/linux-2.4.26-CAN-2004-0415.patch
}

