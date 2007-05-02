# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16.33.ebuild,v 1.1 2007/05/02 03:31:45 marineam Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.xensource.com/xen/xen/"
XEN_VERSION="3.0.4_1"
MY_P="xen-${XEN_VERSION}-src"
XEN_URI="http://bits.xensource.com/oss-xen/release/${XEN_VERSION/_/-}/src.tgz/${MY_P}.tgz"
SRC_URI="${KERNEL_URI} ${XEN_URI}"

KEYWORDS="~x86 ~amd64"

src_unpack() {
	kernel-2_src_unpack
	cd "${WORKDIR}"
	unpack "${MY_P}.tgz"

	cd "${WORKDIR}"/${MY_P}
	sed -e 's:relative_lndir \([^(].*\):cp -dpPR \1/* .:' \
		-i linux-2.6-xen-sparse/mkbuildtree || die

	# Don't munge up EXTRAVERSION
	sed -e 's:$$(XENGUEST)::' -i buildconfigs/mk.linux-2.6-xen

	# No need to run oldconfig
	sed -e 's:$(MAKE) -C $(LINUX_DIR) ARCH=$(LINUX_ARCH) oldconfig::' \
		-i buildconfigs/mk.linux-2.6-xen

	# Move the kernel sources to pristine-linux-${PV}
	mv "${WORKDIR}"/linux-${KV} pristine-linux-${PV} || die
	touch pristine-linux-${PV}/.valid-pristine || die

	make LINUX_SRC_PATH=${DISTDIR} XEN_ROOT=${WORKDIR}/${MY_P} \
		-f buildconfigs/mk.linux-2.6-xen \
		linux-${PV}-xen/include/linux/autoconf.h || die
	mv linux-${PV}-xen "${WORKDIR}"/linux-${KV} || die
	rm -rf "${WORKDIR}/${MY_P}" || die
}

pkg_postinst() {
	postinst_sources

	elog "This kernel uses the linux patches released with Xen ${XEN_VERSION}"
	elog "It may not work with other versions of Xen"
}
