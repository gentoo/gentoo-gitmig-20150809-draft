# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gulm/gulm-1.01.00.ebuild,v 1.1 2006/07/14 15:28:21 xmerlin Exp $

inherit linux-mod

CLUSTER_VERSION="1.01.00"
DESCRIPTION="Redundant server-based cluster and lock manager for GFS"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

IUSE=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"


DEPEND=">=sys-cluster/ccs-1.01.00
	>=sys-cluster/cman-1.01.00
	sys-apps/tcp-wrappers
	"

RDEPEND="sys-apps/tcp-wrappers"


S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure --kernel_src=/usr/src/linux || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -f ${D}/etc/init.d/lock_gulmd
}
