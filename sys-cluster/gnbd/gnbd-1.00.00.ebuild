# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd/gnbd-1.00.00.ebuild,v 1.1 2005/06/30 14:08:26 xmerlin Exp $

CLUSTER_VERSION="1.00.00"
DESCRIPTION="GFS Network Block Devices"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/magma-1.00.00
	>=sys-cluster/gnbd-kernel-1.00.00"


S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/${PN}-client.rc ${PN}-client || die
	newinitd ${FILESDIR}/${PN}-srv.rc ${PN}-src || die

	insinto /etc
	doins ${FILESDIR}/gnbdtab

	if $(has_version sys-fs/devfsd ) ; then
		insinto /etc/devfs.d/
		newins ${FILESDIR}/gnbd.devfs gnbd
	fi
}
