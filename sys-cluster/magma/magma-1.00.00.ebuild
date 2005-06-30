# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma/magma-1.00.00.ebuild,v 1.1 2005/06/30 12:39:32 xmerlin Exp $

inherit eutils

CLUSTER_VERSION="1.00.00"

DESCRIPTION="Magma cluster interface"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-compile.patch || die
}

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/*
}
