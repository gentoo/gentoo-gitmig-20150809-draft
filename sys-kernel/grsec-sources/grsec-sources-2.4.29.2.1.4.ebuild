# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/grsec-sources/grsec-sources-2.4.29.2.1.4.ebuild,v 1.1 2005/03/24 03:51:13 solar Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="yes"
inherit kernel-2
detect_version

OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH/.*/}"
PATCH_BASE="${PV/${OKV}./}"
PATCH_BASE="${PATCH_BASE/_/-}"
EXTRAVERSION="-grsec-${PATCH_BASE}"
PATCH_STAMP=200503212012
KV_FULL="${OKV}${EXTRAVERSION}"
PATCH_SRC_BASE="grsecurity-${PATCH_BASE}-${OKV}-${PATCH_STAMP}.patch.bz2"
DESCRIPTION="Vanilla sources of the linux kernel with the grsecurity ${PATCH_BASE} patch"
SRC_URI="http://grsecurity.net/${PATCH_SRC_BASE} \
	http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 \
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.28-CAN-2004-0814.patch"
#SRC_URI="http://grsecurity.net/~spender/${PATCH_SRC_BASE} ${SRC_URI}"

HOMEPAGE="http://www.kernel.org/ http://www.grsecurity.net"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 -hppa"
RESTRICT="buildpkg"
IUSE=""
RDEPEND=""
UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/${PATCH_SRC_BASE} \
	${FILESDIR}/CAN-2004-1056.patch \
	${FILESDIR}/linux-2.4.28-random-poolsize.patch"


#	${FILESDIR}/CAN-2004-1335.patch
#	${FILESDIR}/2.4.29-CAN-2005-0001.patch 
#	${FILESDIR}/2.4.27-cmdline-race.patch
#	${FILESDIR}/2.4.28-uselib4pax.patch
#	${DISTDIR}/linux-2.4.28-CAN-2004-0814.patch
#	${FILESDIR}/CAN-2004-1074.patch
#	${FILESDIR}/CAN-2004-1016.patch
#	${FILESDIR}/2.4.28-binfmt_a.out.patch
#	${FILESDIR}/gentoo-sources-2.4.CAN-2004-1137.patch

src_unpack() {
	kernel-2_src_unpack

	# users are often confused by what settings should be set.
	# so we provide an  example of what a P4 desktop would look like.
	cp ${FILESDIR}/2.4.24-x86.config gentoo-grsec-custom-example-2.4.2x-x86.config
}
