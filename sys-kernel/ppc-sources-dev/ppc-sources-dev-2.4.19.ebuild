# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later
# $Id: ppc-sources-dev-2.4.19.ebuild,v 1.1 2002/08/17 20:51:20 trance Exp $ 

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.4.19
KV=${PVR}
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

# What's in this kernel?

# INCLUDED:
#	2.4.19-pre-benh
#	preempt patch
#	Ani Joshi's rivafb bigendian fixes from YDL 


DESCRIPTION="Full developmental sources for the Gentoo Linux PPC kernel"
SRC_URI="http://www.penguinppc.org/~kevyn/kernels/gentoo/linux-${OKV}.tar.gz"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.gz
	mv linux linux-${KV} || die
	cd ${S}
	pwd
	
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *
fi

}

src_install() {
	if [ "$ETYPE" = "linux-sources" ]
	then
		dodir /usr/src
		cd ${S}
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
		make dep
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-ppc/* ${D}/usr/include/asm
	fi
}
