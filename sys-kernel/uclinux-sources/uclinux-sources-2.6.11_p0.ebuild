# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/uclinux-sources/uclinux-sources-2.6.11_p0.ebuild,v 1.1 2005/04/08 13:14:13 r3pek Exp $

ETYPE="sources"
K_NOSETEXTRAVERSION="yes"

inherit kernel-2 versionator
detect_version

UC_V="uc${PV/*_p/}"
PATCH_FILE="linux-${OKV}-${UC_V}.patch.gz"

DESCRIPTION="uCLinux kernel patches for CPUs without MMUs"
SRC_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2
		 http://www.uclinux.org/pub/uClinux/uClinux-${KV_MAJOR}.${KV_MINOR}.x/${PATCH_FILE}"

UNIPATCH_LIST="${DISTDIR}/${PATCH_FILE}
			   ${FILESDIR}/kernel-26-security-patches.tar.bz2"
UNIPATCH_STRICTORDER="yes"

HOMEPAGE="http://www.uclinux.org/"
KEYWORDS="~x86"
SLOT="${KV}"
IUSE=""
