# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-1.01.00.ebuild,v 1.1 2005/10/08 14:12:54 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=sys-cluster/magma-1.01.00
	dev-libs/libxml2
	sys-libs/zlib"


S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/${PN}d.rc ${PN}d || die
	newconfd ${FILESDIR}/${PN}d.conf ${PN}d || die
}
