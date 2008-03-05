# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.24.002.2-r1.ebuild,v 1.1 2008/03/05 10:07:26 pva Exp $

inherit versionator

ETYPE="sources"

CKV=$(get_version_component_range 1-3)
OKV=${OKV:-${CKV}}
OVZ_KERNEL="ovz$(get_version_component_range 4)"
if [[ ${PR} == "r0" ]]; then
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4).$(get_version_component_range 5)
EXTRAVERSION=-${OVZ_KERNEL}
else
KV_FULL=${CKV}-${PN/-*}-$(get_version_component_range 4).$(get_version_component_range 5)-${PR}
EXTRAVERSION=-${OVZ_KERNEL}-${PR}
fi
OVZ_REV="$(get_version_component_range 5)"
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
UNIPATCH_LIST="${DISTDIR}/patch-${OVZ_KERNEL}.${OVZ_REV}-combined.gz
${FILESDIR}/openvz-sources-2.6.24.002.2-CPT-select-PM-as-well.patch
${FILESDIR}/openvz-sources-2.6.24.002.2-CPT-select-tun-venet-veth-modules.patch
${FILESDIR}/openvz-sources-2.6.24.002.2-proc-compilation.patch
${FILESDIR}/openvz-sources-2.6.24.002.2-reexport-sys_open.patch
${FILESDIR}/openvz-sources-2.6.24.002.2-SIT-create-sit-devices-in-correct-netns.patch
${FILESDIR}/openvz-sources-2.6.24.002.2-warning-fs-sysfs-dir.c.patch
"
