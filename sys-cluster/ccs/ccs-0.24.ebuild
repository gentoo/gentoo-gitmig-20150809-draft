# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-0.24.ebuild,v 1.2 2005/03/19 21:00:47 xmerlin Exp $

inherit linux-mod

DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${P}.tar.gz"

SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${P}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-cluster/magma-1.0_pre8
	dev-libs/libxml2
	sys-libs/zlib"

src_compile() {
	check_KV

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/ccsd.rc ccsd || die
	insinto /etc/conf.d ; newins ${FILESDIR}/ccsd.conf ccsd || die
}

pkg_postinst() {
	einfo ""
	einfo "Probably you need also the magma-plugins package in your cluster!"
	einfo ""
}
