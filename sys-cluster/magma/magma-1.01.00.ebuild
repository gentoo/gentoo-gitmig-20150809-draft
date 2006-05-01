# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma/magma-1.01.00.ebuild,v 1.6 2006/05/01 11:54:01 corsair Exp $

inherit eutils

MY_P="cluster-${PV}"

DESCRIPTION="Magma cluster interface"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.00.00-compile.patch || die
}

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/*
}
