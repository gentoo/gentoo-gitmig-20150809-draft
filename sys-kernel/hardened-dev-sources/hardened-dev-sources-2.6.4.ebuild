# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.4.ebuild,v 1.1 2004/03/15 01:41:55 solar Exp $

ETYPE="sources"
inherit kernel-2
detect_version

NETRAND_CORE_VER="${OKV}"
NETRAND_DRIVERS_VER="${OKV}"

#GRSEC_VER=2.0-testing-${OKV}
#GRSEC_URI="http://grsecurity.net/grsecurity-${GRSEC_VER}.patch"

# repackage while brad is developing 2.6.x to avoid md5sum conflicts if
# he changes it upstream.

GRSEC_STAMP=20040314
GRSEC_VER=2.0-testing-${GRSEC_STAMP}-${OKV}
GRSEC_URI="http://dev.gentoo.org/~solar/grsecurity/grsecurity-${GRSEC_VER}.patch"

NETRAND_CORE_URI="http://zeus.polsl.gliwice.pl/~albeiro/netdev-random/netdev-random-core-${NETRAND_CORE_VER}.patch"
NETRAND_DRIVERS_URI="http://zeus.polsl.gliwice.pl/~albeiro/netdev-random/netdev-random-drivers-${NETRAND_DRIVERS_VER}.patch"

AVC_PAX_VER=
AVC_PAX_URI=

KEYWORDS="-*"

UNIPATCH_LIST="${DISTDIR}/grsecurity-${GRSEC_VER}.patch
	${DISTDIR}/linux-${OKV}-avc_pax.patch
	${DISTDIR}/linux-${OKV}-audit_textrel.patch
	${DISTDIR}/netdev-random-core-${NETRAND_CORE_VER}.patch
	${DISTDIR}/netdev-random-drivers-${NETRAND_DRIVERS_VER}.patch"


DESCRIPTION="Vanilla sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree patch with the grsecurity patch"
SRC_URI="${KERNEL_URI} ${GRSEC_URI} ${AVC_PAX_URI} ${NETRAND_CORE_URI} ${NETRAND_DRIVERS_URI}"
UNIPATCH_STRICTORDER="yes"

pkg_postinst() {
	postinst_sources
	einfo "UNIPATCH_LIST=$(for p in $UNIPATCH_LIST ; do echo -n "$(basename ${p} .patch), " ; done ; date -u +%Y%m%d.%s)"
	einfo "You sick bastard."
}
