# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-1.0.2.ebuild,v 1.3 2007/05/22 16:22:07 phreak Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://svn.linux-vserver.org/projects/libvserver"
SRC_URI="http://dev.gentoo.org/~hollow/libvserver/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="diet"

DEPEND="diet? ( >=dev-libs/dietlibc-0.28 )"

src_compile() {
	econf $(use_enable diet dietlibc) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
