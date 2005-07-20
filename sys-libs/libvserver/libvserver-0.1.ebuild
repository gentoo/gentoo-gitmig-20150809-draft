# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-0.1.ebuild,v 1.1 2005/07/20 06:25:03 hollow Exp $

DESCRIPTION="Linux-VServer syscall library"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver/libvserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
