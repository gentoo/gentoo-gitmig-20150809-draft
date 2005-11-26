# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-0.4.ebuild,v 1.2 2005/11/26 10:28:36 hollow Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver/libvserver"
SRC_URI="http://dev.gentoo.org/~hollow/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
