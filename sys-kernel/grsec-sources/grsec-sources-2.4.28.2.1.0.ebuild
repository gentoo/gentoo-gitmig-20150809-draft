# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/grsec-sources/grsec-sources-2.4.28.2.1.0.ebuild,v 1.1 2005/01/08 05:21:39 solar Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="yes"
inherit kernel-2
detect_version

OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH/.*/}"
PATCH_BASE="${PV/${OKV}./}"
PATCH_BASE="${PATCH_BASE/_/-}"
EXTRAVERSION="-grsec-${PATCH_BASE}"
PATCH_STAMP=200501051112
KV_FULL="${OKV}${EXTRAVERSION}"
PATCH_SRC_BASE="grsecurity-${PATCH_BASE}-${OKV}-${PATCH_STAMP}.patch"
DESCRIPTION="Vanilla sources of the linux kernel with the grsecurity ${PATCH_BASE} patch"
SRC_URI="http://grsecurity.net/grsecurity-${PATCH_BASE}-${OKV}-${PATCH_STAMP}.patch \
	http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 \
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.28-CAN-2004-0814.patch"

HOMEPAGE="http://www.kernel.org/ http://www.grsecurity.net"
KEYWORDS="x86 sparc ppc alpha amd64 -hppa"
KEYWORDS="-*"
RESTRICT="buildpkg"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/${PATCH_SRC_BASE} \
	${FILESDIR}/2.4.28-binfmt_a.out.patch \
	${FILESDIR}/CAN-2004-1016.patch \
	${FILESDIR}/CAN-2004-1074.patch \
	${FILESDIR}/CAN-2004-1056.patch \
	${DISTDIR}/linux-2.4.28-CAN-2004-0814.patch \
	${FILESDIR}/linux-2.4.28-random-poolsize.patch"

src_unpack() {
	kernel-2_src_unpack

	# users are often confused by what settings should be set.
	# so we provide an  example of what a P4 desktop would look like.
	cp ${FILESDIR}/2.4.24-x86.config gentoo-grsec-custom-example-2.4.2x-x86.config
}
