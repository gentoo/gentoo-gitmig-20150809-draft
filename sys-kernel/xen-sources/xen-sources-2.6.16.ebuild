# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16.ebuild,v 1.1 2006/04/09 21:28:41 chrb Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version
[ "${PR}" == "r0" ] && KV=${PV/_/-}-xen || KV=${PV/_/-}-xen-${PR}

EXTRAVERSION=".${KV_EXTRA}-xen"

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/index.html"
#REV="8738"
#MY_P="xen-3.0-testing-${REV}"
XEN_VERSION="3.0.2"
KERNEL_VERSION="2.6.16"
MY_P="xen-${XEN_VERSION}"
#SRC_URI="${KERNEL_URI} mirror://gentoo/${MY_P}.tar.bz2"
SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-${XEN_VERSION}-src.tgz"

KEYWORDS="~x86 ~amd64"
DEPEND="~app-emulation/xen-${XEN_VERSION}"
S="${WORKDIR}"
RESTRICT="nostrip"

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	sed -e 's:relative_lndir \([^(].*\):cp -dpPR \1/* .:' \
		-i linux-2.6-xen-sparse/mkbuildtree || die
	# the echo is because the current sources seem to have no default for XEN_NETDEV_PIPELINED_TRANSMITTER
	echo "n" | make LINUX_SRC_PATH=${DISTDIR} -f buildconfigs/mk.linux-2.6-xen \
		linux-${KERNEL_VERSION}-xen/include/linux/autoconf.h
	t=linux-${KERNEL_VERSION}-xen
#	cp XEN-VERSION ${t}
	echo ARCH=xen | cat - ${t}/Makefile >${t}/Makefile.0
	mv ${t}/Makefile.0 ${t}/Makefile
	mv ${t} ${WORKDIR}/linux-${KV}
	rm -rf ${WORKDIR}/${MY_P}
}
