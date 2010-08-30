# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.18.028.070.4.ebuild,v 1.1 2010/08/30 11:01:05 pva Exp $

inherit versionator

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
if [[ ${PR} == "r0" ]]; then
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4-6)
else
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4-6)-${PR}
fi
OVZ_KERNEL="$(get_version_component_range 4)stab$(get_version_component_range 5)"
OVZ_REV="$(get_version_component_range 6)"
EXTRAVERSION=-${OVZ_KERNEL}
KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""
PATCHV="194.8.1.el5"
DESCRIPTION="Full sources including OpenVZ patchset for the 2.6.18 kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/rhel5-${CKV}/${OVZ_KERNEL}.${OVZ_REV}/patches/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz
${FILESDIR}/${PN}-2.6.18.028.064.7-bridgemac.patch"

K_EXTRAEINFO="This openvz kernel uses RHEL5 patchset instead of vanilla kernel.
This patchset considered to be more stable and security supported by upstream,
that why they suggested us to use it. But note: RHEL5 patchset is very fragile
and fails to build in many configurations so if you have problems use config
files from openvz team http://wiki.openvz.org/Download/kernel/rhel5/${OVZ_KERNEL}"

K_EXTRAEWARN="This kernel is stable only when built with gcc-4.1.x and is known
to oops in random places if built with newer compilers."
