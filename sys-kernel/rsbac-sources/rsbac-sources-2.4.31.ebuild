# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.4.31.ebuild,v 1.4 2006/02/16 10:18:38 kang Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2
detect_version

#DEPEND=">=sys-apps/rsbac-admin-1.2.4"

# rsbac 
RSBACV=1.2.5

# rsbac kernel patches
RGPV=31.0
RGPV_SRC="http://dev.gentoo.org/~kang/rsbac/patches/${RSBACV}/${KV_MAJOR}.${KV_MINOR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}/0000_README"

HOMEPAGE="http://hardened.gentoo.org/rsbac"
DESCRIPTION="RSBAC hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${RGPV_SRC}"
KEYWORDS="x86 ~amd64"

K_NOUSENAME="yes"
K_PREPATCHED="yes"
K_EXTRAEINFO="Guides are available from the Gentoo Documentation Project for
this kernel
Please see http://www.gentoo.org/proj/en/hardened/rsbac/quickstart.xml
And the RSBAC hardened project http://www.gentoo.org/proj/en/hardened/rsbac/
For help setting up and using RSBAC."
K_EXTRAEWARN="Please now use hardened-sources with the local USE flag rsbac.
See http://hardened.gentoo.org/transition for more information."
