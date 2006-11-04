# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-026.020.ebuild,v 1.2 2006/11/04 09:31:15 hollow Exp $

ETYPE="sources"
CKV="2.6.16"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

OVZ_KERNEL="${PV%%.*}test${PV##*.}"
OVZ_REV="1"

KEYWORDS="~amd64 ~x86 ~ppc64"
IUSE=""

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	mirror://openvz/kernel/devel/${OVZ_KERNEL}.${OVZ_REV}/patches/patch-${OVZ_KERNEL}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${OVZ_KERNEL}-combined.gz"
