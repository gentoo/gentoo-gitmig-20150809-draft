# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/poppassd_pam/poppassd_pam-1.0.ebuild,v 1.2 2003/09/05 09:10:14 msterret Exp $

inherit eutils

DESCRIPTION="POP Password Changer w/PAM support"
HOMEPAGE="http://freshmeat.net/projects/poppassd_pam/
	http://netwinsite.com/poppassd/"
SRC_URI="http://scholar.uws.edu.au/~97074683/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
	>=sys-libs/pam-0.75-r8"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/missing-stdio.patch
}

src_compile() {
	cd ${S}
	${CC} -c ${CFLAGS} ${PN}.c || die "compile failed"
	${CC} -o poppassd ${PN}.o -lpam || die "linking failed"
}

src_install() {
	insinto /usr/bin
	insopts -o root -g bin -m 500
	doins poppassd

	dodoc README

	insinto /etc/pam.d
	newins ${FILESDIR}/poppassd.pam poppassd

	insinto /etc/xinetd.d
	newins ${FILESDIR}/poppassd.xinetd poppassd
}

pkg_postinst() {
	einfo ""
	einfo "Make sure to modify /etc/services and add..."
	einfo ""
	einfo "poppassd		106/tcp"
	einfo ""
}
