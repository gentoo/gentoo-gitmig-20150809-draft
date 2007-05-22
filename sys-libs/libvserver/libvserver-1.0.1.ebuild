# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-1.0.1.ebuild,v 1.2 2007/05/22 16:22:07 phreak Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://svn.linux-vserver.org/projects/libvserver"
SRC_URI="http://dev.gentoo.org/~hollow/libvserver/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
