# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-dev-sources/vserver-dev-sources-1.9.3.17.ebuild,v 1.2 2005/01/07 14:19:27 hollow Exp $

ETYPE="sources"
inherit kernel-2

OKV="2.6.10"
OKB="2.6"
EXTRAVERSION="-vs${PV}-${PR}"
KV_FULL="${OKV}${EXTRAVERSION}"
S="${WORKDIR}/linux-${KV_FULL}"

# workaround, since detect_version in kernel-2.eclass is somewhat broken
KV_MAJOR=2
KV_MINOR=6

DESCRIPTION="vserver patched sources for the ${OKB} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="mirror://kernel/linux/kernel/v${OKB}/linux-${OKV}.tar.bz2
		http://vserver.13thfloor.at/Experimental/patch-${OKV}-vs${PV}.diff"

KEYWORDS="~x86"

UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-vs${PV}.diff"

# workaround, since detect_version in kernel-2.eclass is somewhat broken
src_unpack() {
	universal_unpack
	unipatch ${UNIPATCH_LIST}
	unpack_set_extraversion
}
