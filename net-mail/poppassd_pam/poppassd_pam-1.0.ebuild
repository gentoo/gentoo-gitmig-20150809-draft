# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/poppassd_pam/poppassd_pam-1.0.ebuild,v 1.3 2004/06/19 06:41:39 vapier Exp $

inherit eutils gcc

DESCRIPTION="POP Password Changer w/PAM support"
HOMEPAGE="http://freshmeat.net/projects/poppassd_pam/ http://netwinsite.com/poppassd/"
SRC_URI="http://scholar.uws.edu.au/~97074683/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	>=sys-libs/pam-0.75-r8"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/missing-stdio.patch
}

src_compile() {
	$(gcc-getCC) -c ${CFLAGS} ${PN}.c || die "compile failed"
	$(gcc-getCC) -o poppassd ${PN}.o -lpam || die "linking failed"
}

src_install() {
	dodoc README

	insinto /etc/pam.d
	newins ${FILESDIR}/poppassd.pam poppassd

	insinto /etc/xinetd.d
	newins ${FILESDIR}/poppassd.xinetd poppassd

	insinto /usr/bin
	insopts -o root -g bin -m 500
	doins poppassd || die
}

pkg_postinst() {
	einfo "Make sure to modify /etc/services and add..."
	einfo "poppassd		106/tcp"
}
