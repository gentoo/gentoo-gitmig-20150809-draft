# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.6.99.ebuild,v 1.5 2006/02/16 10:18:38 kang Exp $

IUSE=""
ETYPE="sources"
inherit kernel-2 subversion
detect_version

# rsbac versions
RSBACV=1.2.5

# Gentoo rsbac kernel patches
# arent used in SVN but you can still get them applied if you wish
RGPV=13.0
RGPV_SRC="http://dev.gentoo.org/~kang/rsbac/patches/${RSBACV}/2.6/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"
UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/rsbac-patches-${KV_MAJOR}.${KV_MINOR}-${RGPV}/0000_README"


HOMEPAGE="http://hardened.gentoo.org/rsbac/"
DESCRIPTION="RSBAC hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

#SRC_URI="${KERNEL_URI} ${RGPV_SRC}"
KEYWORDS="~x86 ~amd64"
K_NOUSENAME="yes"
K_PREPATCHED="yes"
K_EXTRAEINFO="Guides are available from the Gentoo Documentation Project for
this kernel
Please see http://www.gentoo.org/proj/en/hardened/rsbac/quickstart.xml
And the RSBAC hardened project http://www.gentoo.org/proj/en/hardened/rsbac/
For help setting up and using RSBAC."
K_EXTRAEWARN="Please configure and compile your RSBAC kernel before installing
rsbac-admin tools. This is a LIVE SVN ebuild, it will probably break you! you
have been warned ! Also, be sure to use the SVN rsbac-admin tools if you use the
SVN sources!"
ESVN_PROJECT="rsbac-sources-2.6-svn"

src_unpack() {
	ESVN_REPO_URI="svn://rsbac.de/rsbac1/linux-kernel/2.6/branches/linux-rsbac"
	subversion_src_unpack
	S=${WORKDIR}/${P}
}
