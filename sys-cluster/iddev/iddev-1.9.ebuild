# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/iddev/iddev-1.9.ebuild,v 1.1 2005/03/19 16:58:05 xmerlin Exp $

inherit linux-mod

DESCRIPTION="iddev"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${P}.tar.gz"

SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${P}.tar.gz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""


src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
