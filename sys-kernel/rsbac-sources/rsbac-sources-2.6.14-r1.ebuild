# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.6.14-r1.ebuild,v 1.1 2006/04/20 09:23:26 kang Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="13"

inherit kernel-2
detect_version
detect_arch

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-4
#HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
HGPV_URI="http://dev.gentoo.org/~kang/rsbac/rsbac-hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/rsbac-hardened-patches-${HGPV}.extras.tar.bz2"
DESCRIPTION="RSBAC Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="x86 amd64"

pkg_setup() {
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
		49*.patch"
}

pkg_postinst() {
	postinst_sources
}

K_EXTRAEINFO="Guides are available from the Gentoo Documentation Project for
this kernel.
Please see http://www.gentoo.org/proj/en/hardened/rsbac/quickstart.xml
And the RSBAC hardened project http://www.gentoo.org/proj/en/hardened/rsbac/
For help setting up and using RSBAC."
