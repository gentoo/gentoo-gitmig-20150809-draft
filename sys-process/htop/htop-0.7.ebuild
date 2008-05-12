# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.7.ebuild,v 1.5 2008/05/12 18:00:33 corsair Exp $

inherit flag-o-matic

IUSE="debug"
DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86 ~x86-fbsd"
DEPEND="sys-libs/ncurses"

pkg_setup() {
	if use elibc_FreeBSD ; then
		elog
		elog "htop needs /proc mounted to work, to mount it type"
		elog "mount -t linprocfs none /proc"
		elog "or uncomment the example in /etc/fstab"
		elog
	fi
}

src_compile() {
	useq debug && append-flags -O -ggdb -DDEBUG
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO
}
