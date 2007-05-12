# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman/cman-1.03.00.ebuild,v 1.5 2007/05/12 13:18:52 xmerlin Exp $

inherit eutils

CLUSTER_RELEASE="1.03.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="general-purpose symmetric cluster manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND="=sys-cluster/ccs-${CLUSTER_RELEASE}*
	=sys-cluster/cman-headers-${CLUSTER_RELEASE}*"

RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.03.00-compile-hack.patch || die
	epatch ${FILESDIR}/${PN}-1.03.00-qdisk-makefile.patch || die
}


src_compile() {
	./configure || die "configure problem"
	emake -j1 || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
	newconfd ${FILESDIR}/${PN}.conf ${PN} || die

	newinitd ${FILESDIR}/qdiskd.rc qdiskd || die

	keepdir /etc/cluster || die
}

pkg_postinst() {
	einfo ""
	einfo "Please add a cluster.conf in /etc/cluster ."
	einfo ""
}
