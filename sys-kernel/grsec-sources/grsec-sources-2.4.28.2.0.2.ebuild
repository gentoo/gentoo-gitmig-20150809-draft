# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/grsec-sources/grsec-sources-2.4.28.2.0.2.ebuild,v 1.3 2004/11/26 17:14:49 dsd Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="yes"
inherit kernel-2
detect_version

OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH/.*/}"
PATCH_BASE="${PV/${OKV}./}"
PATCH_BASE="${PATCH_BASE/_/-}"
EXTRAVERSION="-grsec-${PATCH_BASE}"
KV_FULL="${OKV}${EXTRAVERSION}"

PATCH_SRC_BASE="grsecurity-${PATCH_BASE}-${OKV}.patch.gz"
DESCRIPTION="Vanilla sources of the linux kernel with the grsecurity ${PATCH_BASE} patch"
SRC_URI="http://grsecurity.net/grsecurity-${PATCH_BASE}-${OKV}.patch.gz \
	http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"

HOMEPAGE="http://www.kernel.org/ http://www.grsecurity.net"
KEYWORDS="x86 sparc ppc alpha amd64 -hppa"
RESTRICT="buildpkg"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/${PATCH_SRC_BASE}"

src_unpack() {
	kernel-2_src_unpack

	# users are often confused by what settings should be set.
	# so we provide an  example of what a P4 desktop would look like.
	cp ${FILESDIR}/2.4.24-x86.config gentoo-grsec-custom-example-2.4.2x-x86.config
}
