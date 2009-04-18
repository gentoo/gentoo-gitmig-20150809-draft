# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.27.2.1.ebuild,v 1.1 2009/04/18 20:10:36 bangert Exp $

inherit versionator

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
OVZ_REV="$(get_version_component_range 5)"
OVZ_KERNEL="briullov"
if [[ ${PR} == "r0" ]]; then
	EXTRAVERSION=-${PN/-*}-${OVZ_KERNEL}.${OVZ_REV}
else
	EXTRAVERSION=-${PN/-*}-${OVZ_KERNEL}.${OVZ_REV}-${PR}
fi
KV_FULL=${CKV}${EXTRAVERSION}
KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/${CKV}/${CKV}-${OVZ_KERNEL}.${OVZ_REV}/patches/patch-${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

K_EXTRAEINFO="This is development branch of openvz-sources. For more information
about this kernel tak a look at:
http://wiki.openvz.org/Download/kernel/${CKV}/${CKV}-${OVZ_KERNEL}.${OVZ_REV}"
