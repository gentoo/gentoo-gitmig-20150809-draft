# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pfeifer-sources/pfeifer-sources-2.4.22-r2.ebuild,v 1.1 2003/09/21 04:10:18 iggy Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.22"
KV="pfeifer-r${PR/r/}"
S="${WORKDIR}/linux-${OKV}"

EXTRAVERSION="`echo ${KV}|sed -e 's:[^-]*\(-.*$\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"

DESCRIPTION="Full sources for the prerelease vanilla Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~iggy/pfeifer-${OKV}-r2.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	unpack pfeifer-${OKV}-r2.tar.bz2
	mv linux-${OKV} linux-${OKV}-${KV}
	cd ${WORKDIR}/linux-${OKV}-${KV}
	echo "patching kernel with gentoo voodoo magic!"

	for i in ../kernelfiles/* ; do
		#echo "applying patch ${i}"
		patch -p1 -s <${i} || die "Failed to apply ${i}"
	done

	OLDVER="EXTRAVERSION ="
	NEWVER="EXTRAVERSION =-${KV}"
	sed "s/$OLDVER/$NEWVER/g" Makefile > Makefile.new
	mv Makefile.new Makefile

	if [ "`find ${WORKDIR}/linux-${OKV}-${KV}/ '(' -name '*.rej' -o -name '.*.rej' ')' -print`" ] ; then
		ewarn "Reject files found. Please -contact- the Gentoo Kernel Team before using this kernel!!"
		return 1;
	fi

	find ${WORKDIR}/linux-${OKV}-${KV}/ '(' -name '*.orig' -o -name '.*.orig' ')' -exec rm -f {} \;
}
