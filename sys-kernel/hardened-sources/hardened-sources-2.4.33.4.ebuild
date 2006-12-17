# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.33.4.ebuild,v 1.1 2006/12/17 21:22:40 pappy Exp $

ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Hardened kernel sources ${PV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened"

MY_PATCH_TBZ="${P}-patches.tar.bz2"

SRC_URI="${SRC_URI} ${KERNEL_URI} mirror://gentoo/${MY_PATCH_TBZ}"

KEYWORDS="~x86"

LICENSE="${LICENCE:-GPL-2}"

# the eclass is setting the slot to PV
SLOT="${SLOT:-0}"

IUSE="${IUSE}"

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/${MY_PATCH_TBZ}"

