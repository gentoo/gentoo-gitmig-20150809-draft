# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma/magma-1.0_pre21.ebuild,v 1.2 2005/03/23 02:46:23 xmerlin Exp $

inherit eutils

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Magma cluster interface"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

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
