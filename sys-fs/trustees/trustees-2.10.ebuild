# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/trustees/trustees-2.10.ebuild,v 1.2 2003/10/27 20:39:58 max Exp $

DESCRIPTION="Advanced permission management system (ACLs) for Linux."
HOMEPAGE="http://trustees.sourceforge.net/"
SRC_URI="http://trustees.sourceforge.net/download/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/linux-sources
	>=sys-apps/sed-4"

S="${WORKDIR}"

src_unpack() {
	[ ! -e "/usr/src/linux/include/linux/trustee_struct.h" ] && {
		eerror
		eerror "Your currently linked kernel (/usr/src/linux) hasn't"
		eerror "been patched for trustees support."
		eerror
		die "kernel not patched for trustees support"
	}

	unpack ${A}

	# fix linking error
	sed -e '0,0i #include <errno.h>' \
		-i "${S}/set-trustee.c" || die "sed failed"
}

src_compile() {
	${CC} -I/usr/src/linux/include \
		-o "settrustee" "set-trustee.c" || die "compile problem"
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
