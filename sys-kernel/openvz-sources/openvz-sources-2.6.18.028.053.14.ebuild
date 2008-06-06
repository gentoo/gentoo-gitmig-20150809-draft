# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.18.028.053.14.ebuild,v 1.1 2008/06/06 05:39:33 pva Exp $

inherit versionator

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
if [[ ${PR} == "r0" ]]; then
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4).$(get_version_component_range 5)
else
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4).$(get_version_component_range 5)-${PR}
fi
OVZ_KERNEL="$(get_version_component_range 4)stab$(get_version_component_range 5)"
OVZ_REV="$(get_version_component_range 6)"
EXTRAVERSION=-${OVZ_KERNEL}
KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/rhel5-${CKV}/${OVZ_KERNEL}.${OVZ_REV}/patches/patch-53.1.19.el5.${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-53.1.19.el5.${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

K_EXTRAEINFO="Starting with openvz-sources-2.6.18.028.053.14 we use RHEL5 patchset
instead of previously used 2.6.18 one. This patchset considered to be more stable
and security supported by upstream, that why they suggested us to use it."
