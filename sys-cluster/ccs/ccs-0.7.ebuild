# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-0.7.ebuild,v 1.2 2005/01/27 04:36:25 xmerlin Exp $

inherit eutils

DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-cluster/magma
	dev-libs/libxml2
	"

src_compile() {
	./configure --kernel_src=/usr/src/linux || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
