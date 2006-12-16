# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16.28-r1.ebuild,v 1.1 2006/12/16 03:55:01 aross Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version
[ "${PR}" == "r0" ] && KV=${PV/_/-}-xen || KV=${PV/_/-}-xen-${PR}

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/index.html"
XEN_VERSION="3.0.2"
MY_P="xen-${XEN_VERSION}"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/patch-${PV}.bz2 http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-${XEN_VERSION}-src.tgz"

KEYWORDS="~x86 ~amd64"
S="${WORKDIR}"
RESTRICT="nostrip"
XEN_KV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	mv "${WORKDIR}"/patch-${PV} patches/linux-${XEN_KV}/linux-${PV}.patch \
		|| die "failed to mv ${WORKDIR}/patch-${PV}"
	sed -e 's:relative_lndir \([^(].*\):cp -dpPR \1/* .:' \
		-i linux-2.6-xen-sparse/mkbuildtree || die

	# No need to run oldconfig
	sed -e 's:$(MAKE) -C $(LINUX_DIR) ARCH=$(LINUX_ARCH) oldconfig::' \
		-i buildconfigs/mk.linux-2.6-xen

	make LINUX_SRC_PATH=${DISTDIR} -f buildconfigs/mk.linux-2.6-xen \
		linux-${XEN_KV}-xen/include/linux/autoconf.h || die
	mv linux-${XEN_KV}-xen "${WORKDIR}"/linux-${KV} || die
	rm -rf "${WORKDIR}"/linux-${XEN_KV} || die
	rm -rf "${WORKDIR}/${MY_P}" || die

	cd "${WORKDIR}"/linux-${KV}
	epatch "${FILESDIR}/${P}"-CVE-2006-3468.patch
	epatch "${FILESDIR}/${P}"-CVE-2006-6333.patch
}
