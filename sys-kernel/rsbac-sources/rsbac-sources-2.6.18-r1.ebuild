# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.6.18-r1.ebuild,v 1.1 2006/12/06 15:53:29 kang Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="3"

inherit kernel-2 unipatch-001
detect_version

RDEPEND="${RDEPEND}
	>=sys-apps/rsbac-admin-1.3.0"

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-2
#HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
HGPV_URI="mirror://gentoo/rsbac-hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/rsbac-hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="RSBAC Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~amd64 ~x86"

K_EXTRAEINFO="Guides are available from the Gentoo Documentation Project for
this kernel.
Please see http://www.gentoo.org/proj/en/hardened/rsbac/quickstart.xml
And the RSBAC hardened project http://www.gentoo.org/proj/en/hardened/rsbac/
For help setting up and using RSBAC."
