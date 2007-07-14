# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.6.20.1.ebuild,v 1.2 2007/07/14 23:11:23 mr_bones_ Exp $

ETYPE="sources"

inherit kernel-2

detect_version

PATCHSET="${PV}"

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="${KERNEL_URI}
http://dev.gentoo.org/~gmsoft/patches/hppa-sources-patchset-${PATCHSET}.tar.bz2
mirror://gentoo/4300_squashfs-3.0.patch.bz2"

UNIPATCH_LIST="${DISTDIR}/hppa-sources-patchset-${PATCHSET}.tar.bz2
${DISTDIR}/4300_squashfs-3.0.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org/"
KEYWORDS="-* hppa"
