# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-1.1-r3.ebuild,v 1.4 2004/08/15 08:27:16 lv Exp $

DESCRIPTION="Base libraries for emulation of 32bit x86 on amd64"
SRC_URI="mirror://gentoo/distfiles/emul-linux-x86-baselibs-1.1.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
# Compiled with CFLAGS="-march=athlon-xp -msse2", won't work on ia64 or intel's em64t
KEYWORDS="-* amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"

src_install() {
	cd ${WORKDIR}
	mkdir -p ${D}/emul/linux/x86
	mkdir -p ${D}/emul/linux/x86/lib/dev-state
	mkdir -p ${D}/emul/linux/x86/lib/security/pam_filter
	mkdir -p ${D}/emul/linux/x86/lib/rcscripts/sh
	mkdir -p ${D}/emul/linux/x86/lib/rcscripts/awk
	mkdir -p ${D}/emul/linux/x86/usr/lib/misc
	mkdir -p ${D}/emul/linux/x86/usr/lib/awk
	mkdir -p ${D}/emul/linux/x86/usr/lib/gcc-config
	mkdir -p ${D}/emul/linux/x86/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2
	mkdir -p ${D}/emul/linux/x86/usr/lib/gettext
	mkdir -p ${D}/emul/linux/x86/usr/lib/gconv
	mkdir -p ${D}/emul/linux/x86/usr/lib/nsbrowser/plugins
	mkdir -p ${D}/emul/linux/x86/usr/lib/glib/include
	mkdir -p ${D}/emul/linux/x86/usr/lib/pkgconfig
	mkdir -p ${D}/etc/env.d

	# Fixes BUG #49678
	mkdir -p ${D}/lib
	# Fixes BUG #51034
	mkdir -p ${D}/usr
	mv ${WORKDIR}/etc/env.d/75emul-linux-x86-baselibs ${D}/etc/env.d/
	chmod 644 ${D}/etc/env.d/75emul-linux-x86-baselibs
	rm -Rf ${WORKDIR}/etc
	cp -RPvf ${WORKDIR}/* ${D}/emul/linux/x86/

	# Fixes BUG #47817 && BUG #55247
	cd ${D}/emul/linux/x86/usr/lib
	sed -i -e "s/\/lib\//\/lib32\//g" libc.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpthread.so
	sed -i -e "s/\/lib\//\/lib32\//g" libcom_err.so
	sed -i -e "s/\/lib\//\/lib32\//g" libe2p.so
	sed -i -e "s/\/lib\//\/lib32\//g" libext2fs.so
	sed -i -e "s/\/lib\//\/lib32\//g" libhistory.so
	sed -i -e "s/\/lib\//\/lib32\//g" libncurses.so
	sed -i -e "s/\/lib\//\/lib32\//g" libblkid.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpam.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpam_misc.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpamc.so
	sed -i -e "s/\/lib\//\/lib32\//g" libpwdb.so
	sed -i -e "s/\/lib\//\/lib32\//g" libreadline.so
	sed -i -e "s/\/lib\//\/lib32\//g" libss.so
	sed -i -e "s/\/lib\//\/lib32\//g" libuuid.so

	ln -sf /emul/linux/x86/lib/ld-linux.so.2 ${D}/lib/ld-linux.so.2
	ln -sf /emul/linux/x86/lib ${D}/lib32
	ln -sf /emul/linux/x86/usr/lib ${D}/usr/lib32
}
