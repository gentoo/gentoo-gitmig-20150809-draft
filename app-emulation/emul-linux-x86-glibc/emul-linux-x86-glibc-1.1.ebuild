# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-glibc/emul-linux-x86-glibc-1.1.ebuild,v 1.5 2004/08/30 15:01:28 lv Exp $

DESCRIPTION="GNU C Library for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-glibc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/libc
		!<app-emulation/emul-linux-x86-baselibs-1.2"

S=${WORKDIR}

src_install() {
	# Fixes BUG #49678
	mkdir -p ${D}/lib
	ln -sf /emul/linux/x86/lib/ld-linux.so.2 ${D}/lib/ld-linux.so.2
	ln -sf /emul/linux/x86/lib ${D}/lib32

	# Fixes BUG #51034
	mkdir -p ${D}/usr
	ln -sf /emul/linux/x86/usr/lib ${D}/usr/lib32

	cd ${WORKDIR}/emul/linux/x86/usr/lib32 || die
	# fix linker scripts to point to lib32
	sed -i -e "s/\/lib\//\/lib32\//g" libc.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpthread.so

	cp -aRpvf ${WORKDIR}/* ${D}/

	# create env.d entry
	mkdir -p ${D}/etc/env.d
	cat > ${D}/etc/env.d/40emul-linux-x86-glibc <<ENDOFENV
LDPATH=/lib32:/usr/lib32:/emul/linux/x86/lib:/emul/linux/x86/usr/lib
ENDOFENV
	chmod 644 ${D}/etc/env.d/40emul-linux-x86-glibc
}

run_verbose() {
	echo "running $@"
	$@ || die "unable to $@"
}

