# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.4.ebuild,v 1.2 2004/03/15 04:34:26 solar Exp $

ETYPE="sources"
inherit kernel-2
detect_version


AVC_PAX_VER="2.6.4"
NETRAND_CORE_VER="2.6.3"
NETRAND_DRIVERS_VER="2.6.3"

# repackage while brad is developing 2.6.x to avoid md5sum conflicts 
# if he changes the codebase upstream.
#GRSEC_VER=2.0-testing-${OKV}
#GRSEC_URI="http://grsecurity.net/grsecurity-${GRSEC_VER}.patch"

GRSEC_STAMP=20040314
GRSEC_VER=2.0-testing-${GRSEC_STAMP}-${OKV}
GRSEC_URI="http://dev.gentoo.org/~solar/grsecurity/grsecurity-${GRSEC_VER}.patch"

GRSEC_EXTRAS_URI="http://dev.gentoo.org/~solar/grsecurity/linux-${OKV}-grsec-2.0-textrel.patch"

AVC_PAX_URI="http://tachyon.snu.edu/linux-${AVC_PAX_VER}-selinux-hooks.patch"

NETRAND_CORE_URI="http://zeus.polsl.gliwice.pl/~albeiro/netdev-random/netdev-random-core-${NETRAND_CORE_VER}.patch"
NETRAND_DRIVERS_URI="http://zeus.polsl.gliwice.pl/~albeiro/netdev-random/netdev-random-drivers-${NETRAND_DRIVERS_VER}.patch"

KEYWORDS="-*"

UNIPATCH_LIST="
	${DISTDIR}/grsecurity-${GRSEC_VER}.patch
	${DISTDIR}/linux-${OKV}-grsec-2.0-textrel.patch
	${DISTDIR}/linux-${AVC_PAX_VER}-selinux-hooks.patch
	${DISTDIR}/netdev-random-core-${NETRAND_CORE_VER}.patch"
#	${DISTDIR}/netdev-random-drivers-${NETRAND_DRIVERS_VER}.patch"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GRSEC_URI} ${GRSEC_EXTRAS_URI} ${AVC_PAX_URI} ${NETRAND_CORE_URI} ${NETRAND_DRIVERS_URI}"
UNIPATCH_STRICTORDER="yes"

pkg_postinst() {
	postinst_sources
	einfo "UNIPATCH_LIST=$(for p in $UNIPATCH_LIST ; do echo -n "$(basename ${p} .patch), " ; done ; date -u +%Y%m%d.%s)"
}
