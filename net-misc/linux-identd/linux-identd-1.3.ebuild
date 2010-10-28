# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-identd/linux-identd-1.3.ebuild,v 1.15 2010/10/28 12:34:21 ssuominen Exp $

IUSE="xinetd"
DESCRIPTION="A real IDENT daemon for linux."
HOMEPAGE="http://www.fukt.bth.se/~per/identd"
SRC_URI="http://www.fukt.bth.se/~per/identd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~hppa ~mips ia64 ~amd64"

DEPEND=""
RDEPEND="xinetd? ( sys-apps/xinetd )"

src_compile() {
	emake CEXTRAS="${CFLAGS}" || die
}

src_install() {
	dodir /etc/init.d /usr/sbin /usr/share/man/man8
	dodoc README ChangeLog
	make install DESTDIR="${D}" MANDIR=/usr/share/man || die
	cp "${FILESDIR}"/identd "${D}"/etc/init.d
}
