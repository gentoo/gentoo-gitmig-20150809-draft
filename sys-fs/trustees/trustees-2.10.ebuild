# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/trustees/trustees-2.10.ebuild,v 1.4 2004/03/10 18:16:50 max Exp $

DESCRIPTION="Advanced permission management system (ACLs) for Linux."
HOMEPAGE="http://trustees.sourceforge.net/"
SRC_URI="http://trustees.sourceforge.net/download/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/linux-sources"

S="${WORKDIR}"

pkg_setup() {
	[ ! -e "/usr/src/linux/include/linux/trustee_struct.h" ] && {
		eerror
		eerror "Your currently linked kernel (/usr/src/linux) hasn't"
		eerror "been patched for trustees support."
		eerror
		die "kernel not patched for trustees support"
	}

	return 0
}

src_compile() {
	CFLAGS="${CFLAGS} -I/usr/src/linux/include -include errno.h"

	echo ${CC} ${CFLAGS} set-trustee.c -o settrustee
	${CC} ${CFLAGS} set-trustee.c -o settrustee || die "compile problem"
}

src_install() {
	dosbin settrustee

	dodoc README
	newdoc trustee.conf trustee.conf.example

	exeinto /etc/init.d
	newexe "${FILESDIR}/trustees.rc6" trustees
	insinto /etc/conf.d
	newins "${FILESDIR}/trustees.conf" trustees
}
