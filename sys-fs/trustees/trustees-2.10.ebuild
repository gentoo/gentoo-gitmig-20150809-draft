# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/trustees/trustees-2.10.ebuild,v 1.8 2004/10/28 16:01:11 vapier Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Advanced permission management system (ACLs) for Linux"
HOMEPAGE="http://trustees.sourceforge.net/"
SRC_URI="http://trustees.sourceforge.net/download/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	virtual/linux-sources"

S="${WORKDIR}"

src_compile() {
	if [ ! -e "${ROOT}/usr/src/linux/include/linux/trustee_struct.h" ] ; then
		eerror
		eerror "Your currently linked kernel (/usr/src/linux) hasn't"
		eerror "been patched for trustees support."
		eerror
		die "kernel not patched for trustees support"
	fi

	append-flags -I${ROOT}/usr/src/linux/include -include errno.h

	$(tc-getCC) ${CFLAGS} set-trustee.c -o settrustee || die "compile problem"
}

src_install() {
	dosbin settrustee || die
	dodoc README
	newdoc trustee.conf trustee.conf.example

	exeinto /etc/init.d
	newexe "${FILESDIR}/trustees.rc6" trustees
	insinto /etc/conf.d
	newins "${FILESDIR}/trustees.conf" trustees
}
