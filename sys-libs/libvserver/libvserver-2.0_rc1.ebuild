# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-2.0_rc1.ebuild,v 1.1 2007/06/20 18:09:28 hollow Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://svn.linux-vserver.org/projects/libvserver/"
SRC_URI="http://people.linux-vserver.org/~hollow/libvserver/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=dev-libs/lucid-0.1*"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
