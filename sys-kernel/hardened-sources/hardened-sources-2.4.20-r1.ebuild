# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="build selinux"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.20
EXTRAVERSION=-hardened-r1
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Special Security Hardened Gentoo Kernel (don't use this yet, it isn't ready)"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
 	 mirror://gentoo/patches-${KV}.tar.bz2"


HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/hardened/"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2 patches-${KV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	
	cd ${KV}
	# We can't use LSM/SELinux and GRSec in the same kernel.  If USE=selinux, we will
	# patch in LSM/SELinux and drop support for GRsec.  Otherwise we will include GRSec.
	if [ "`use selinux`" ]; then
		einfo "Enabling SELinux support.  This will drop GRSec support."
		for file in *grsec*; do
			einfo "Dropping ${file}.."
			rm -f ${file}
		done
	else
		einfo "Did not find \"selinux\" in use, building with GRSec support."
		for file in *lsm* *selinux*; do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	fi
	
	kernel_src_unpack
}

src_install() {
	if [ "`use selinux`" ]; then
		insinto /usr/flask
		doins ${S}/security/selinux/flask/access_vectors
		doins ${S}/security/selinux/flask/security_classes
		doins ${S}/security/selinux/flask/initial_sids
		insinto /usr/include/linux/flask
		doins ${S}/security/selinux/include/linux/flask/*.h
		insinto /usr/include/asm/flask
		doins ${S}/security/selinux/include/asm/flask/uninstd.h
	fi

	kernel_src_install
}

pkg_postinst() {
	einfo "This kernel contains LSM/SElinux or GRSecurity, and Systrace"
	einfo "This is not yet a production ready kernel.  If you experience problems with"
	einfo "this kernel please report them by assigning bugs on bugs.gentoo.org to"
	einfo "frogger@gentoo.org"
}
