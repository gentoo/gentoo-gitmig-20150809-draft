# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-identd/linux-identd-1.3-r1.ebuild,v 1.6 2010/10/28 12:34:21 ssuominen Exp $

IUSE="xinetd"
DESCRIPTION="A real IDENT daemon for linux."
HOMEPAGE="http://www.fukt.bth.se/~per/identd"
SRC_URI="http://www.fukt.bth.se/~per/identd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc sparc x86"

DEPEND=""
RDEPEND="xinetd? ( sys-apps/xinetd )"

src_compile() {
	emake CEXTRAS="${CFLAGS}" || die
}

src_install() {
	dodir /etc/init.d /usr/sbin /usr/share/man/man8
	dodoc README ChangeLog
	make install DESTDIR="${D}" MANDIR=/usr/share/man || die

	if use xinetd; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/identd.xinetd identd
	else
		newinitd "${FILESDIR}"/identd.init identd
	fi
}
