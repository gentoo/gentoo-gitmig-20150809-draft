# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-20040626.ebuild,v 1.1 2004/06/27 14:50:09 zypher Exp $

MY_P=gfs-${PV}
DESCRIPTION="Cluster configuration system"
HOMEPAGE="http://sources.redhat.com/cluster"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=""

S=${WORKDIR}/${MY_P}/${PN}

src_compile() {
	./configure --kernel_src=/usr/src/linux-2.6.8-gfs || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
}
