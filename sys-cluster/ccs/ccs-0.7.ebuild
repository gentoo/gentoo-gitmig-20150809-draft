# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-0.7.ebuild,v 1.4 2005/03/07 04:33:09 xmerlin Exp $

inherit linux-mod

DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-cluster/magma-1.0_pre3
	dev-libs/libxml2
	sys-libs/zlib
	"

RDEPEND="${DEPEND}
	>=magma-plugins-1.0_pre5
	"

src_compile() {
	check_KV

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
