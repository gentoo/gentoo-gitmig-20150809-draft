# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xmbmon/xmbmon-2.0.3.ebuild,v 1.8 2004/07/21 22:31:58 lv Exp $

inherit gnuconfig eutils

MY_P="${PN}${PV//.}"
DESCRIPTION="Mother Board Monitor Program for X Window System"
HOMEPAGE="http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html"
SRC_URI="http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"

DEPEND="virtual/libc
	X? ( virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xmbmon-2.0.3-gcc34.patch
}

src_compile() {
	gnuconfig_update

	econf || die "Configure failed"
	emake DEFS="$DEFS -DLINUX" CFLAGS="$CFLAGS \$(INCLUDES) \$(DEFS)" mbmon || die "Make mbmon failed"
	if use X ; then
		emake DEFS="$DEFS -DLINUX" CFLAGSX="$CFLAGS \$(INCLUDES) \$(DEFS)" xmbmon || die "Make xmbmon failed"
	fi
}

src_install() {
	dosbin mbmon
	fperms 4555 /usr/sbin/mbmon
	fowners root:wheel /usr/sbin/mbmon

	if use X ; then
		dosbin xmbmon
		fperms 4555 /usr/sbin/xmbmon
		fowners root:wheel /usr/sbin/xmbmon
	fi

	dodoc 00README*
}

pkg_postinst() {
	echo
	einfo "These programs access SMBus/ISA-IO ports without any kind"
	einfo "of checking.  It is, therefore, very dangerous and may cause"
	einfo "a system-crash. Make sure you read 00README.txt,"
	einfo "section 4, 'How to use!'"
	echo
	ewarn "Binaries are setuid root!"
	echo
}
