# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-1.2.2-r2.ebuild,v 1.2 2005/01/18 01:28:31 eradicator Exp $

DESCRIPTION="Base libraries for emulation of 32bit x86 on amd64"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-baselibs-${PV}.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

# stop confusing portage 0.o
S=${WORKDIR}

DEPEND="virtual/libc
	>=sys-apps/sed-4
	app-emulation/emul-linux-x86-glibc
	app-emulation/emul-linux-x86-compat"

src_install() {
	cd ${WORKDIR}
	cp -RPvf ${WORKDIR}/* ${D}/

	# Don't want this anymore... it's provided by portage.
	if [ -d "/lib32" ]; then
		rm ${D}/emul/linux/x86/lib/libsandbox.so
	fi

	# oops. fix bug 65276
	cd ${D}/emul/linux/x86/lib/
	ln -s libz.so.? libz.so

	# create env.d entry
	mkdir -p ${D}/etc/env.d
	cat > ${D}/etc/env.d/75emul-linux-x86-base <<ENDOFENV
LDPATH=/emul/linux/x86/lib:/emul/linux/x86/usr/lib
ENDOFENV
	chmod 644 ${D}/etc/env.d/75emul-linux-x86-base
}
