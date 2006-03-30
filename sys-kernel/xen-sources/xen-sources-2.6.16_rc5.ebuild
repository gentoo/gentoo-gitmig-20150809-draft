# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16_rc5.ebuild,v 1.3 2006/03/30 03:43:43 agriffis Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version
[ "${PR}" == "r0" ] && KV=${PV/_/-}-xen || KV=${PV/_/-}-xen-${PR}

EXTRAVERSION=".${KV_EXTRA}-xen"

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/index.html"
REV="9029"
MY_P="xen-unstable-${REV}"
SRC_URI="${KERNEL_URI} mirror://gentoo/${MY_P}.tar.bz2"

KEYWORDS="~x86 ~amd64"
DEPEND="~app-emulation/xen-3.0.1_p${REV}"
S="${WORKDIR}"
RESTRICT="nostrip"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${MY_P}
	sed -e 's:relative_lndir \([^(].*\):cp -dpPR \1/* .:' \
		-i linux-2.6-xen-sparse/mkbuildtree || die
	# the echo is because the current sources seem to have no default for XEN_NETDEV_PIPELINED_TRANSMITTER
	LINUX=linux-${PV/_/-}-xen
	echo "n" | make LINUX_SRC_PATH=${DISTDIR} -f buildconfigs/mk.linux-2.6-xen \
		${LINUX}/include/linux/autoconf.h || die
	cp XEN-VERSION ${LINUX}
	mv ${LINUX} ${WORKDIR}/linux-${KV}
	rm -rf ${WORKDIR}/${MY_P}
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "This is a snapshot of the xen-unstable tree."
	einfo "Please report bugs in xen itself (and not the packaging) to"
	einfo "bugzilla.xensource.com"
}
