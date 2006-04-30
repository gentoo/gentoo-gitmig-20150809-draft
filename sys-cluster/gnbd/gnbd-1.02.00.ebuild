# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd/gnbd-1.02.00.ebuild,v 1.1 2006/04/30 13:09:41 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="GFS Network Block Devices"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=sys-cluster/magma-1.02.00
	>=sys-cluster/gnbd-headers-1.02.00"


S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/${PN}-client.rc ${PN}-client || die
	newinitd ${FILESDIR}/${PN}-srv.rc ${PN}-srv || die

	doconfd ${FILESDIR}/${PN}-client.conf || die
	doconfd ${FILESDIR}/${PN}-srv.conf || die

	insinto /etc
	doins ${FILESDIR}/gnbdtab

	if $(has_version sys-fs/devfsd ) ; then
		insinto /etc/devfs.d/
		newins ${FILESDIR}/gnbd.devfs gnbd
	fi
}
