# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xmbmon/xmbmon-2.0.1.ebuild,v 1.2 2003/06/21 21:19:41 drobbins Exp $

MY_P="${PN}${PV//.}"
DESCRIPTION="Mother Board Monitor Program for X Window System"
HOMEPAGE="http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html"
SRC_URI="http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/${MY_P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {

	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {

	dosbin mbmon
	fperms 4555 /usr/sbin/mbmon
	fowners root.wheel /usr/sbin/mbmon

	if use X; then
		dosbin xmbmon
        	fperms 4555 /usr/sbin/xmbmon
		fowners root.wheel /usr/sbin/xmbmon
        fi
	
	dodoc 00README*	
}

pkg_postinst() {

	einfo "These programs access SMBus or ISA-IO port without any kind"
	einfo "of checking.  It is, therefore, very dangerous and may cause"
	einfo "system-crash in worst cases. Make sure you read 00README.txt,"
	einfo "section 4, How to use!"
	
	ewarn "Binaries are setuid root!"
}
