# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs/gfs-20040626.ebuild,v 1.1 2004/06/27 15:12:02 zypher Exp $

DESCRIPTION="GlobalFileSystem - userland tools"
HOMEPAGE="http://sources.redhat.com/cluster"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="=sys-cluster/ccs-20040626
	=sys-cluster/cman-20040626
	=sys-cluster/dlm-20040626
	=sys-cluster/fence-20040626
	=sys-cluster/iddev-20040626"

S=${WORKDIR}/${P}/${PN}

src_compile() {
	./configure --kernel_src=/usr/src/linux-2.6.7-gfs || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc ../doc/usage.txt
}

