# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/planet-ccrma-sources/planet-ccrma-sources-2.4.21-r5.ebuild,v 1.1 2004/02/18 23:54:45 plasmaroo Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel || die
inherit rpm || die

OKV=2.4.21
EXTRAVERSION="-1.ll.acpi"
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}

# This package contains the Linux Kernel source for the version of the
# RedHat Linux Kernel modified by the Planet CCRMA project.
#
# Do not report problems with this source package or the resulting compiled
# compiled kernel to Red Hat, Inc.  Red Hat is not responsible for this
# package and has offered no warranties or promises that the kernels
# resulting from the compilation of this package will work on anything
# except specific versions of the Red Hat distribution and specific
# compiler revisions.
#
# Gentoo provides this package without any guarantees that this kernel
# will compile and run correctly and will only respond to bug reports
# dealing with Gentoo specific packaging problems.

# The easiest way to grab Red Hat kernel sources is from the rpm file
# itself.  We used to generate a patch against vanilla sources trees but
# the added dependency of rpm2targz is minimal compared with having to
# generate a new diff for every minor version update.  (Also not to many
# people have 2.4.18 vanilla source tarballs floating around these days)

DEPEND="virtual/glibc"

DESCRIPTION="Kernel source used in Planet CCRMA custom audio upgrade (based on RedHat)"
SRC_URI="http://ccrma-www.stanford.edu/planetccrma/mirror/redhat/linux/planetcore/9/en/os/i386/kernel-source-${KV}.i386.rpm mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://ccrma-www.stanford.edu/ http://www.kernel.org/ http://www.redhat.com/"
KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {

	rpm_unpack ${DISTDIR}/kernel-source-${KV}.i386.rpm
	cd ${WORKDIR}

	tar xvzf ${DISTDIR}/${P}.tar.gz || die

	mv usr/src/linux-${KV} ${WORKDIR} || die

	cd ${S}

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	epatch ${FILESDIR}/${PN}.munmap.patch || die "Failed to apply munmap patch!"

	kernel_universal_unpack
}

pkg_postinst() {

	ewarn "This kernel should now work with ALSA 0.9.6 or better."
	ewarn "You'll need ~x86 for ALSA greater than 0.9.2"

	einfo "A default kernel config has been provided in"
	einfo "distfiles/planet-ccrma-sources-2.4.21.tar.gz."
	einfo "Copy it to /usr/src/linux/.config and run make oldconfig."
	einfo "Then edit to taste, but be careful not to tweak too much."
	einfo "Just make sure to enable the devfs support."
	einfo "And never run with scissors..."

	ewarn "Mount your /boot partition and copy the file"
	ewarn "PORTDIR/sys-kernel/planet-ccrma-sources/files/kernel.h"
	ewarn "to /boot before you configure and build the kernel."
	einfo "Don't ask why; it's a RedHat thing..."
}
