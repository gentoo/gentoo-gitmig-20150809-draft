# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/compaq-sources/compaq-sources-2.4.9.32.7.ebuild,v 1.1 2003/05/13 18:49:07 taviso Exp $

ETYPE="sources"
inherit kernel
OKV=2.4.9
KV=${OKV}-32.7
EXTRAVERSION="-compaq"
S=${WORKDIR}/linux-${KV}

# This ebuild installs the sources for the Linux kernel shipped with the
# latest version of Red Hat Linux for Alpha, maintained by Compaq.
#
# -taviso <taviso@gentoo.org>
#

DEPEND="${DEPEND} 
	app-arch/rpm2targz
	>=sys-apps/sed-4"

REDPEND=""
DESCRIPTION="Kernel from the Compaq Distribution of Red Hat Linux (ALPHA)."
SRC_URI="ftp://ftp2.compaq.com/pub/linux/RedHat/7.2-alpha/updates/rpms/alpha/kernel-source-${KV}.alpha.rpm"
HOMEPAGE="http://www.kernel.org/ http://www.redhat.com/ http://www.support.compaq.com/alpha-tools/redhat/" 
KEYWORDS="-* ~alpha"
SLOT="${KV}"

src_unpack() {
	local kernel_rpm="kernel-source-${KV}.alpha.rpm"
	cd ${WORKDIR}
	
	ebegin "Unpacking Distribution RPM..."
	
	# agriffis' fast+efficient rpm extraction method from
	# the dev-lang/ccc ebuild.
	# 
	i=${DISTDIR}/${kernel_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
	| gzip -dc | cpio -idmu 2>/dev/null \
	&& find usr -type d -print0 | xargs -0 chmod a+rx
	eend ${?}
	assert "Failed to extract ${kernel_rpm%.rpm}.tar.gz"
	
	mv usr/src/linux-${KV} ${WORKDIR}
	cd ${S} 
	
	# just fix a couple of minor issues...
	sed -i 's#include/linux/autoconf.h \(include/linux/version.h \\\)#\1#' Makefile
	sed -i 's#\(extern\) \(unsigned long irq_err_count;\)#\1 volatile \2#' arch/alpha/kernel/irq_alpha.c
	sed -i 's#/DISCARD/ : { \*(.text.exit)#/DISCARD/ : {#' arch/alpha/vmlinux.lds.in	
	
	# hand it over to the eclass...
	kernel_universal_unpack
}

pkg_postinst () {
	einfo "This ebuild has installed the sources for the Linux kernel shipped with the"
	einfo "latest version of Red Hat Linux Alpha, maintained by Compaq."
	einfo
	einfo "Compaq lag behind releases from kernel.org, but their kernels are"
	einfo "extensively tested, and used by many thousands. This kernel will include"
	einfo "bugfixes and extended hardware support, and is probably the most widely"
	einfo "used Linux kernel on the Alpha Platform today."
	einfo 
	ewarn "DO NOT Report issues with this kernel to Red Hat or Compaq, use"
	ewarn "the Gentoo Linux bugzilla at http://bugs.gentoo.org/"
	einfo
}
