# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mnet/mnet-0.6.1.199.ebuild,v 1.1 2003/02/25 01:07:22 hannes Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="Mnet is a universal file space. It is formed by an emergent network of autonomous nodes which self-organize to make the network robust and efficient."
SRC_URI="mirror://sourceforge/${PN}/${P}-STABLE-src.tar.bz2"
HOMEPAGE="http://mnet.sourceforge.net/"

DEPEND="dev-lang/python"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"

src_compile() {
	EXTSRCDIR="${WORKDIR}/extsrc/" MNETDIR="${S}" make build
}

src_install() {
	dodoc COPYING CREDITS ChangeLog overview.txt hackerdocs/*
	dobin Mnet.sh
	rm Mnet.sh COPYING CREDITS ChangeLog overview.txt hackerdocs/*
	dodir /usr/share/mnet
	cp -r ${S}/* ${D}/usr/share/mnet
	insinto /etc/env.d
	doins ${FILESDIR}/96mnet
}

pkg_postinst() {
	einfo "please run 'env-update' and 'source /etc/profile',"
	einfo "then execute 'Mnet.sh'"
}
