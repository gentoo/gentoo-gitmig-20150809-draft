# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16_rc3-r1.ebuild,v 1.1 2006/02/21 09:48:59 chrb Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version
[ "${PR}" == "r0" ] && KV=${PV/_/-}-xen || KV=${PV/_/-}-xen-${PR}

EXTRAVERSION=".${KV_EXTRA}-xen"

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/index.html"
REV="8885"
MY_P="xen-unstable-${REV}"
#MY_P="xen-3.0.1"
SRC_URI="${KERNEL_URI} mirror://gentoo/${MY_P}.tar.bz2"
#SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-3.0.1-src.tgz"

KEYWORDS="~x86 ~amd64"
DEPEND="=app-emulation/xen-${REV}"
S="${WORKDIR}"
RESTRICT="nostrip"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${MY_P}
	sed -e 's:relative_lndir \([^(].*\):cp -dpPR \1/* .:' \
		-i linux-2.6-xen-sparse/mkbuildtree || die
	# the echo is because the current sources seem to have no default for XEN_NETDEV_PIPELINED_TRANSMITTER
	echo "n" | make LINUX_SRC_PATH=${DISTDIR} -f buildconfigs/mk.linux-2.6-xen \
		linux-2.6.16-rc3-xen/include/linux/autoconf.h || die
	t=linux-2.6.16-rc3-xen
	cp XEN-VERSION ${t}
	mv ${t} ${WORKDIR}/linux-${KV}
	rm -rf ${WORKDIR}/${MY_P}
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "This is a snapshot of the xen-unstable tree."
	einfo "Please report bugs in xen itself (and not the packaging) to"
	einfo "bugzilla.xensource.com"
}
